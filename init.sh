#!/bin/bash
set -e

# Restore dependencies if needed
if [ ! -d ".venv" ]; then
  PIPENV_VENV_IN_PROJECT=true pipenv sync
fi
