#!/bin/bash
set -e
pre-commit run --all-files
jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace ./notebooks/*.ipynb
