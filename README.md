# Container images for DiracX

This repository contains the recipes and CI for building the base images used by DiracX.

## Available images

### secret-generation

This image is used by the [helm chart](https://github.com/DIRACGrid/diracx-charts) to run batch jobs within the cluster that automatically generate kubernetes secrets.

### server-base

This image is used as the base of the diracx service image.
