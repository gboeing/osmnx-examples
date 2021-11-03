#!/bin/bash
set -e
nbqa isort ./notebooks/*.ipynb --line-length 100 --sl
nbqa black ./notebooks/*.ipynb --line-length 100
nbqa flake8 ./notebooks/*.ipynb --max-line-length 100
jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace ./notebooks/*.ipynb
