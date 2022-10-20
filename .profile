# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/profile.pre.bash"
# ssh
export SSH_KEY_PATH="${HOME}/.ssh/id_rsa"


# brew
eval $(/opt/homebrew/bin/brew shellenv)

# set NVM environment
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# set Android Environment Variables
# export JAVA_HOME=$(/usr/libexec/java_home) # latest java version
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
export ANDROID_HOME=${HOME}/Library/Android/sdk
export ANDROID_SDK_ROOT=${HOME}/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Goolge Java Formatter
export PATH=${PATH}:/opt/homebrew/bin/google-java-format

# set flutter env
export PATH=${PATH}:${HOME}/Library/flutter/bin

# set go dev env
export GOPATH=$HOME/dev/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

### Sonarcube
export SONAR_HOME=/usr/local/Cellar/sonar-scanner/4.3.0.2102/libexec
export SONAR=$SONAR_HOME/bin export
export PATH=$PATH:$SONAR

### Adds sbin to path
export PATH="/usr/local/sbin:$PATH"

### RabbitMQ
export PATH=$PATH:/usr/local/opt/rabbitmq/sbin

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/profile.post.bash" ]] && builtin source "$HOME/.fig/shell/profile.post.bash"
