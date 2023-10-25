#!/bin/bash
set -e

# TODO: This is a workaround until this is released
# https://github.com/DaanDeMeyer/reproc/pull/103
# or that this is merged
# https://github.com/conda-forge/reproc-feedstock/pull/10
ulimit -n 8192

eval "$(micromamba shell hook --shell=posix)"
micromamba activate base
exec "$@"
