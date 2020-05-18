#### zsh configuration ####

# Path to your oh-my-zsh installation.
export ZSH="/Users/charpi/.oh-my-zsh"

ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Don't mark VCS untracked file as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

ENABLE_CORRECTION="true"

# Don't share history between tmux panes
setopt nosharehistory


#### Plugins ####

# Careful too many plugins make opening a shell very slow
plugins=(
  #brew 
  git
  gitfast
  zsh-autosuggestions
  zsh-completions
  #aws
  #docker
  jsontools
  #pip
  #pyenv
  #python
  #golang
  #terraform
  sudo
  tmux
  vscode
)
# maybe add vi-mode as well ?


####  Plugins tuning ####

## Autosuggestion ##
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# Manual rebinding boost perf but need to handle re-binding yourself every now and then by running _zsh_autosuggest_bind_widgets
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-execute

## tmux ##
ZSH_TMUX_AUTOSTART=true

## completions ##
# load completion but not everytime to avoid slowing down too much new prompt creation
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

## Measure execution time of the last command run and display it to the right of the prompt ##
function preexec() {
  timer=${timer:-$SECONDS}
}
function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export RPROMPT="%F{cyan}${timer_show}s %{$reset_color%}"
    unset timer
  fi
}

# Run oh my zsh and tune zsh. Any zsh related config has to be written above this line.
source $ZSH/oh-my-zsh.sh


#### User configuration ####

## Generic env var ##
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export PAGER="less"
export EDITOR=/usr/local/bin/nvim
export CLICOLOR="screen-256color"
export PATH="$PATH:$HOME/bin"
# Fix aws cli problem on OS X
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## Aliases ##
alias v="nvim"
alias c="vsc"
alias cr="vscr"
# colorise cat, remember \cat to bypass the alias
alias cat="ccat"
alias s3ls="aws s3 ls --recursive --human-readable"
# Remove docker images, you can run it in a daily cron job
alias docker-remove-images-older-than-3-days='docker image prune -a --filter "until=72h"'
#s3curl : https://github.com/rtdp/s3curl
alias s3curl="/usr/local/bin/s3curl.pl"
# example to display portion of a file:
# s3curl --id pint -- -s -H "Range: bytes=0-20000"  http://fh-provider-prod.s3.amazonaws.com/hotel/json/regular/provider_partition=ean/date_partition=2018-05-14-05-02-46/data.json.gz | gzip -d
alias glg="git lg"
alias glg1="git lg1"
alias glg2="git lg2"
alias glg3="git lg3"
clone_from_github () {
    git clone https://github.com/$1/$2 ${3:-$2}
}
alias gclo="clone_from_github"
alias gsm="git add .; git commit -m \"#Squash me\""
# Update master from remote origin master without checking out from my current branch. Works only for fast-forward merges (which should always be the case when updating master from origin master).
alias gupm="git fetch origin master:master"
alias grbim="git rebase -i master"
alias gcmp="git checkout master && git pull origin master"

alias goerr="errcheck -blank ./..."

## Retrieve sensible credentials ##
credfile="$HOME/.cred"
credfigfile_secured="/tmp/.cred"
# check if the file contains something we don't want
if egrep -q -v '^#|^[^ ]*=[^;]*' "$credfile"; then
  egrep '^#|^[^ ]*=[^;&]*'  "$credfile" > "$credfile_secured"
  credfile="$credfile_secured"
fi
# now source it
source "$credfile"

## Colour man pages ##
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan

## Safe colors in tmux ##
export TERM="screen-256color"
alias tmux="tmux -2"

## pyenv ##
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

## golang ##
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

## nvm ##
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

## ruby ##
# Let homebrew ruby take precedence over the system's one
export PATH="$PATH:/usr/local/opt/ruby/bin"

## psql cli setup example ##
# Redshift cluster through ssh tunnel
# (without tunnel, just replace the localhost ip directly with the database ip)
export RS_PTEXT_PWD
export RS_PTEXT_USER
export RS_PTEXT_PORT
export RS_PTEXT_DB
# Open CLI
alias psql_ptext="PGPASSWORD=$RS_PTEXT_PWD psql -h 127.0.0.1 -U $RS_PTEXT_USER -p $RS_PTEXT_PORT -d $RS_PTEXT_DB -a"
# Run sql from a file and return result live
function live_run_ptext() {
    PGPASSWORD=$RS_PTEXT_PWD psql -h 127.0.0.1 -U $RS_PTEXT_USER -p $RS_PTEXT_PORT -d $RS_PTEXT_DB -a -f $1
}
alias lrunptex="live_run_ptext"
# Run sql from a file and output result to file
function run_ptext() {
    PGPASSWORD=$RS_PTEXT_PWD psql -h 127.0.0.1 -U $RS_PTEXT_USER -p $RS_PTEXT_PORT -d $RS_PTEXT_DB -A -F"," -f $1 -o $2.csv
}
alias runptex="run_ptext"

## kubectl autocompletion ##
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

## GPG prompt ##
export GPG_TTY=`tty`

## local ES folder ##
export ES_HOME=~/Applications/elasticsearch-6.2.2
export PATH="$PATH:$ES_HOME/bin"

## message bird API keys and phone number ##
export MBIRD_TEST
export MBIRD_LIVE_A
export MBIRD_LIVE_I
export PHONE_NUMBER
