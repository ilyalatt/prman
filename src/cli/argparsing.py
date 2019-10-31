import argparse
import os
import logging
import sys
import json


def read_args():
  parser = argparse.ArgumentParser()
  parser.add_argument(
    "--dir",
    required=True,
    help='Working directory'
  )
  parser.add_argument(
    "--config",
    required=True,
    help='Config file path'
  )

  args = parser.parse_args()
  if not os.path.exists(args.dir):
    logging.error("Working directory '%s' does not exist.", args.config)
    sys.exit(1)
  if not os.path.exists(args.config):
    logging.error("Config path '%s' does not exist.", args.config)
    sys.exit(1)
  return args

def read_json_file(file_path):
  with open(file_path, 'r') as file:
    file_content = file.read()
  return json.loads(file_content)


def read_args_and_config():
  args = read_args()
  config = read_json_file(args.config)
  args.config = config
  return args
