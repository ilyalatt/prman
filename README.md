# PR Man!

## TLDR

```
> prman
The repo name: control_server
The current branch: f/GOL-123-some-description
Fetching PR's...
Fetching approvers...
Select approvers:
1. jfisher (Jared Fisher)
2. choiii (Peyton Choi)
3. ldavid (Lemar David)
> fisher;choi
Pushing to the origin...
Creating the PR...
The PR is created: https://gitlab.com/goldmine-run/control_server/merge_requests/42
```

## Why?

Creating a PR in GitLab UI takes so much time.
You need to click a button, select options like 'Squash', 'Remove source branch when merged'.
You need to select minimal approvers count.
You need to select approvers.
You should set approvers as assignee to give them email about your PR.

It is a pure nightmare.
Just run `prman` in your repo directory.
Type approvers like `fisher;choi`.
It pushes your branch to the origin automatically.
A Pull Request is done!

## How to install it?

* `snap install prman --classic`.
* If you type `prman` and get `command not found` the run `echo 'export PATH="$PATH:/snap/bin"' >> ~/.bashrc && source ~/.bashrc`.
* Go to [GitLab Access Tokens UI](https://gitlab.com/profile/personal_access_tokens).
* Name: `prman`, Scopes: `api`, Create personal access token.
* Create `config.json` based on `config_template.json` and replace `gitlab_token` with your token.
* Run `source setup_bash_alias.sh`.

## How to select approvers?

* You can type a substring of an item by a query like `fisher`.
* You can type multiple items separated by `;` like in a query `fisher;choi`.
* You can select item by index with a query like `3`.
* You can select an index range with a query like `3..5`.
* Parts of a query can intersects like `2;1..3;fisher`.
