"""PR Man!

Usage:
  prman config get <key>
  prman config set <key> <value>
  prman [-m <message>|--message <message>]
"""
from docopt import docopt


def read_args():
  return docopt(__doc__, version='prman 0.1.0')
