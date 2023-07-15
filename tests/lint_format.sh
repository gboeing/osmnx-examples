#!/bin/bash
set -e
pre-commit run --all-files
jupyter nbconvert --clear-output --inplace ./notebooks/*.ipynb
