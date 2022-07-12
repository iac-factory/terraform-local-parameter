#!/usr/bin/env sh

echo "# $(basename "$(git rev-parse --show-toplevel)") #" > "$(pwd)/documentation/header.md"