#!/bin/bash
set -e

WD=$(pwd)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

bash init.sh

CONFIG=$DIR/config.json

source .venv/bin/activate
python3 src/main.py --config $CONFIG --dir $WD $@
