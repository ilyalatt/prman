#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LAUNCHER=$DIR/run.sh

add_to_file() {
  if ! grep -q "$1" "$2" ; then
    echo "$1" | tee -a "$2"
  fi
}

BASH_RC=$HOME/.bashrc
add_to_file $"alias prman='$LAUNCHER'" "$BASH_RC"
source "$BASH_RC"
