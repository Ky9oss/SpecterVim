#!/bin/bash
# 
# Ky9oss

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# busted "$CURRENT_DIR/../lua/tests/test.lua"
nvim --headless -c "PlenaryBustedDirectory $CURRENT_DIR/../lua/tests/ {}" # {options}
