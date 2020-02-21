#!/bin/bash
TARGET=vscode-extensions-list.txt
echo "dump all vscode file extension names into $TARGET"
code --list-extensions >> $TARGET
