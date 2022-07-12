#!/usr/bin/env sh

echo "# $(basename "$(git rev-parse --show-toplevel)") #" > "$(pwd)/documentation/header.md"

terraform output --json > "$(pwd)/documentation/header.md"