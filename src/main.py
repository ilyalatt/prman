# pylint: disable=unused-wildcard-import
from cli.argparsing import *
from cli.interaction import *
from git.git_interop import *
from git.git_conventions import *
from gl.gitlab_interop import *
from gl.gitlab_conventions import *
from toolz.curried import *
import logging


def main():
  args = read_args_and_config()
  config = args.config

  repo = get_repo(args.dir)
  repo_name = get_repo_name(repo)
  print_repo_name(repo_name)

  remote_url = get_first_remote_url(repo)
  project_id = extract_gitlab_project_id(remote_url)
  print_project_id(project_id)

  current_branch = get_current_branch(repo)
  print_current_branch(current_branch)

  gl_client = init_gitlab_client(config['gitlab_url'], config['gitlab_token'])
  project = get_project(gl_client, project_id)

  print_fetching_prs()
  mrs = get_mrs_list(project)

  mrs_for_current_branch = pipe(mrs, filter(lambda x: x.source_branch == current_branch), list)
  mr_for_current_branch = None if len(mrs_for_current_branch) == 0 else mrs_for_current_branch[0]
  if not mr_for_current_branch is None:
    print_mr_is_already_created(current_branch, mr_for_current_branch.web_url)
    return

  res = get_issue_name_and_message(config['branch_regex'], current_branch)
  if res is None:
    print_current_branch_has_bad_format(current_branch)
    return
  (branch_issue_name, branch_message) = res
  mr_name = create_mr_name(branch_issue_name, branch_message)

  print_fetching_users()
  users = get_project_users_except_me_and_ci(gl_client, project)
  approvers = select_approvers(users)
  approver_ids = pipe(approvers, map(lambda x: x.id), list)

  print_pushing_to_origin()
  push_origin(repo)

  print_creating_mr()
  mr = create_mr(
    config['maximum_required_approvers_count'],
    gl_client,
    project,
    current_branch,
    'master',
    mr_name,
    approver_ids
  )

  mr_web_url = mr.web_url
  print_mr_is_created(mr_web_url)


if __name__ == '__main__':
  main()
