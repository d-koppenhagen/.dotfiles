#!/bin/bash

# see: https://mkyong.com/java/how-to-install-java-on-mac-osx/

brew install java # install
brew upgrade openjdk # update (if already installed)
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk # set symbolic link


