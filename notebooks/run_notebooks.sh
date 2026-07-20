#!/bin/bash
set -euo pipefail

export MPLBACKEND="Agg"
CACHE_DIR="./cache"
CACHE_READY_FILE="${CACHE_DIR}/.cache_ready"

# test notebooks serially until the cache is ready, then in parallel
WORKERS=1
if [[ -f "$CACHE_READY_FILE" ]]; then
    WORKERS=4
fi

# convert the notebooks to .py files to execute them
uv run jupyter nbconvert --to python *.ipynb
uv run python -c "import osmnx; print(osmnx.__version__)"
mkdir -p data images "$CACHE_DIR"

echo "Running notebooks with ${WORKERS} process(es)."
if (( WORKERS == 1 )); then
    for filename in *.py; do
        uv run ipython "$filename"
    done
else
    printf '%s\n' *.py | xargs -n1 -P4 uv run ipython
fi

# mark the cache ready after each fully successful run
touch "$CACHE_READY_FILE"
