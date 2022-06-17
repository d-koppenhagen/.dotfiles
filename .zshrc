# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="muse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  # zsh-nvm
  brew
  iterm2
  npm
  golang
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias ls='ls -G'
alias ll='ls -lha'
alias buch="cd ${HOME}/dev/Angular-Buch/buch"
alias dev="cd ${HOME}/dev"
alias play='cd ~/dev/playground && ls -l'
alias genyshell='/Applications/Genymotion\ Shell.app/Contents/MacOS/genyshell'
alias npmcheck='npm outdated -g --depth=0; echo "Please run npm update -g --depth=0 to update all global packages"'
alias javaversions="/usr/libexec/java_home -V"

### Functions Start
# shortcut for open TexStudio within given path
function texstudio() {
  TEXSTUDIO_PATH="/Applications/texstudio.app/Contents/MacOS/texstudio"
  if [[ ! -e $TEXSTUDIO_PATH ]]; then
    echo "TexStudio App not found. Expected in: $TEXSTUDIO_PATH"
  else
    $TEXSTUDIO_PATH "$1" &
  fi
}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
  local tmpFile="${@%/}.tar"
  tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

  size=$(
    stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
    stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
  )

  local cmd=""
  if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    cmd="zopfli"
  else
    if hash pigz 2> /dev/null; then
      cmd="pigz"
    else
      cmd="gzip"
    fi
  fi

  echo "Compressing .tar using \`${cmd}\`…"
  "${cmd}" -v "${tmpFile}" || return 1
  [ -f "${tmpFile}" ] && rm "${tmpFile}"
  echo "${tmpFile}.gz created successfully."
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# All the dig info
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
  if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "Testing ${domain}…"
  echo # newline

  local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" 2>&1);

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_header, no_serial, no_version, \
      no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
    echo "Common Name:"
    echo # newline
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
    echo # newline
    echo "Subject Alternative Name(s):"
    echo # newline
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
  else
    echo "ERROR: Certificate not found.";
    return 1
  fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
  if [ $# -eq 0 ]; then
    vim .
  else
    vim "$@"
  fi
}

# `o` with no arguments opens current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0 ]; then
  open .
  else
    open "$@"
  fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

fromhex(){
  hex=${1#"#"}
  r=$(printf '0x%0.2s' "$hex")
  g=$(printf '0x%0.2s' ${hex#??})
  b=$(printf '0x%0.2s' ${hex#????})
  printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 +
    (g<75?0:(g-35)/40)*6   +
    (b<75?0:(b-35)/40)     + 16 ))"
}

# switch java jdk version
# run `javaversions` to see available jdk versionss
# run e.g. `jdk 11` when output contains `11.0.1 (x86_64)`. for example:
# 11.0.1 (x86_64) "Oracle Corporation" - "Java SE 11.0.1" /Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
jdk() {
  version=$1
  unset JAVA_HOME;
  export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
  java -version
}
### Functions End

### Go development Start
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
### Go development End

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/dannykoppenhagen/.sdkman"
[[ -s "/Users/dannykoppenhagen/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/dannykoppenhagen/.sdkman/bin/sdkman-init.sh"

# Add hook to actively load relevant nvm version from defined engine
autoload -U add-zsh-hook
node-version-switcher() {
  local node_version="$(node -v | sed -E 's/v([[:digit:]]+).*/\1/g')"

  if defined_version_range=$(node -pe "require('./package.json').engines.node" 2>/dev/null); then
    local desired_major_version=$(echo $defined_version_range | sed -E 's/>=[ ]?([[:digit:]]+).*/\1/g')
    echo Switching to "node${desired_major_version}"
    eval "nvm use ${desired_major_version}"
  fi
}
add-zsh-hook chpwd node-version-switcher
node-version-switcher

# needed for git PGP-signed commits
# also needed for sops
GPG_TTY=$(tty)
export GPG_TTY

# Export Krew PATH
export PATH="${PATH}:${HOME}/.krew/bin"

# Mob
export MOB_OPEN_COMMAND="code %s"

# Load Angular CLI autocompletion.
source <(ng completion script)

if [ -e ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
