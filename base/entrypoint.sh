#!/bin/bash
set -e

eval "$(micromamba shell hook --shell=posix)"
micromamba activate base
exec "$@"
