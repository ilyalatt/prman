#!/bin/bash
set -e

./build_snap.sh
sudo snap install --dangerous --classic prman.snap
