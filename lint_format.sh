#!/bin/bash
set -e
nbqa isort notebooks/*.ipynb --nbqa-mutate
nbqa black notebooks/*.ipynb --nbqa-mutate
nbqa flake8 notebooks/*.ipynb --max-line-length 100
jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace notebooks/*.ipynb
