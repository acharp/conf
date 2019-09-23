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
alias d="datagrip"
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

## vscode pylama and yapf installation for when we are not in a virtualenved project ##
export PATH="$PATH:$HOME/Library/Python/3.7/bin"

## Redshift psql cli setup ##
# Plaintext cluster (open ssh tunnel first)
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
# Pseudo cluster (open ssh tunnel first)
export RS_PSEUDO_PWD
export RS_PSEUDO_USER
export RS_PSEUDO_PORT
export RS_PSEUDO_DB
alias psql_pseudo="PGPASSWORD=$RS_PSEUDO_PWD psql -h 127.0.0.1 -U $RS_PSEUDO_USER -p $RS_PSEUDO_PORT -d $RS_PSEUDO_DB -a"
function live_run_pseudo() {
    PGPASSWORD=$RS_PSEUDO_PWD psql -h 127.0.0.1 -U $RS_PSEUDO_USER -p $RS_PSEUDO_PORT -d $RS_PSEUDO_DB -a -f $1
}
alias lrunpseu="live_run_pseudo"
function run_pseudo() {
    PGPASSWORD=$RS_PSEUDO_PWD psql -h 127.0.0.1 -U $RS_PSEUDO_USER -p $RS_PSEUDO_PORT -d $RS_PSEUDO_DB -A -F"," -f $1 -o $2.csv
}
alias runpseu="run_pseudo"
# Snowplow cluster (no need for ssh tunnel):
export RS_SPLOW_PWD
export RS_SPLOW_USER
export RS_SPLOW_PORT
export RS_SPLOW_HOST
# Since the snowplow pwd has a backslash we cannot add PGPASSWORD=$RS_SNOWPLOW_PWD in the psql_splow command so we define it as the default PGPASSWORD
export PGPASSWORD
alias psql_splow="psql -h $RS_SPLOW_HOST -U $RS_SPLOW_USER -p $RS_SPLOW_PORT -d $RS_SPLOW_DB -a"
function live_run_splow() {
    psql -h $RS_SPLOW_HOST -U $RS_SPLOW_USER -p $RS_SPLOW_PORT -d $RS_SPLOW_DB -a -f $1
}
alias lrunsplo="live_run_splow"
function run_splow() {
    psql -h $RS_SPLOW_HOST -U $RS_SPLOW_USER -p $RS_SPLOW_PORT -d $RS_SPLOW_DB -A -F"," -f $1 -o $2.csv
}
alias runsplo="run_splow"

## kubectl autocompletion ##
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

## wetransfer platform user needed for ssh ##
export WT_PLATFORM_USER

## mysql client config for live read stat db
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
alias mysql_live="mysql --host=127.0.0.1 --port=3307 -u arnaud -D live -p"
