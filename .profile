# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/profile.pre.bash"
# ssh
export SSH_KEY_PATH="${HOME}/.ssh/id_rsa"

# brew
eval $(/opt/homebrew/bin/brew shellenv)

# set NVM environment
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# set Android Environment Variables
# export JAVA_HOME=$(/usr/libexec/java_home) # latest java version
# JAVA_HOME: default to a Homebrew-installed JDK (prefer 21, fall back to 17). The Homebrew JDKs
# are keg-only and not registered with /usr/libexec/java_home, so we point at them directly. Use
# the `jdk <version>` function (see .zshrc) to switch per shell when a project needs another JDK.
if [ -x /opt/homebrew/opt/openjdk@21/bin/java ]; then
  export JAVA_HOME=/opt/homebrew/opt/openjdk@21
elif [ -x /opt/homebrew/opt/openjdk@17/bin/java ]; then
  export JAVA_HOME=/opt/homebrew/opt/openjdk@17
fi
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

# Graphviz
export GRAPHVIZ_DOT="/opt/homebrew/bin/dot"
export PATH=$PATH:$GRAPHVIZ_DOT

### Sonarcube
export SONAR_HOME=/usr/local/Cellar/sonar-scanner/4.3.0.2102/libexec
export SONAR=$SONAR_HOME/bin export
export PATH=$PATH:$SONAR

### Adds sbin to path
export PATH="/usr/local/sbin:$PATH"

### RabbitMQ
export PATH=$PATH:/usr/local/opt/rabbitmq/sbin

# Disable Google Telemetry
DISABLE_TELEMETRY=1

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/profile.post.bash"
