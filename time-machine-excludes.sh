#!/bin/bash
# exclude all `node_modules` inside the `~/dev` directory
find "$HOME/dev" \
  -name 'node_modules' \
  -prune \
  -type d \
  -exec tmutil addexclusion {} \; \
  -exec tmutil isexcluded {} \;
echo "Done. The excluded files won't be part of a time machine backup anymore."
