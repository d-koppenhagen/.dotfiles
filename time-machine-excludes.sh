#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# exclude all `node_modules` folders within the dev directory
find ~/dev -name 'node_modules' -prune -type d -exec tmutil addexclusion {} \; -exec tmutil isexcluded {} \;

echo "Done. The excluded files won't be part of a time machine backup anymore."
