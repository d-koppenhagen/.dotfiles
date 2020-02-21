#!/bin/bash
TARGET=vscode-extensions-list.txt
echo "install all vscode extension files from $TARGET"
cat $TARGET | xargs -n 1 code --install-extension
