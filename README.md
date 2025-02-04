# Container images for DiracX

This repository contains the recipes and CI for building the base images used by DiracX.

See [documentation](https://github.com/DIRACGrid/diracx/blob/main/docs/VERSIONING.md#container-images)

## Available images

### secret-generation

This image is used by the [helm chart](https://github.com/DIRACGrid/diracx-charts) to run batch jobs within the cluster that automatically generate kubernetes secrets.



## How to build

The most up to date documentation on how to build is the [CI job](.github/workflows/main.yml)

```bash

docker build -t ghcr.io/diracgrid/diracx/base:latest base
docker build -t ghcr.io/diracgrid/diracx/servces-base:latest services-base/
```