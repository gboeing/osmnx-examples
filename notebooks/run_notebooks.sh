#!/usr/bin/env bash
set -euo pipefail

CACHE_DIR="./cache"
CACHE_READY_FILE="${CACHE_DIR}/.cache_ready"

WORKERS=1
if [[ -f "$CACHE_READY_FILE" ]]; then
    WORKERS=4
fi
echo "Running notebooks with ${WORKERS} process(es)."

mkdir -p data images "$CACHE_DIR"
uv run python -c "import osmnx; print(osmnx.__version__)"
uv run jupyter nbconvert --to python *.ipynb

if (( WORKERS == 1 )); then
    for filename in *.py; do
        uv run ipython "$filename"
    done
else
    printf '%s\n' *.py | xargs -n1 -P4 uv run ipython
fi

# only a fully successful run can declare the cache complete
touch "$CACHE_READY_FILE"
