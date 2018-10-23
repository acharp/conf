##### GENERAL #####

export PAGER="less"

export EDITOR=/usr/bin/vim

export CLICOLOR="screen-256color"

export PATH="$PATH:$HOME/bin"

alias ..="cd .."
alias la="ls -A"
alias g="git"
alias v="vim"
alias s3ls="aws s3 ls --recursive --human-readable"

alias awspint="export AWS_PROFILE=fh-pint && export AWS_REGION=eu-west-1" 
alias awslabrador="export AWS_PROFILE=fh-labrador && export AWS_REGION=eu-west-1" 

# you can run it in a daily cron job
alias docker-remove-images-older-than-3-days='docker image prune -a --filter "until=72h"'

# Fix aws cli problem on OS X
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Retrieve sensible credentials
credfile="$HOME/.cred"
credfigfile_secured="/tmp/.cred"
# check if the file contains something we don't want
if egrep -q -v '^#|^[^ ]*=[^;]*' "$credfile"; then
  egrep '^#|^[^ ]*=[^;&]*'  "$credfile" > "$credfile_secured"
  credfile="$credfile_secured"
fi
# now source it
source "$credfile"

# Colour man pages
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan

# Safe colors in tmux
export TERM="screen-256color"
alias tmux="tmux -2"

# bash autocompletion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# RVM profile
source ~/.profile

# thefuck command correction
eval $(thefuck --alias)

###### GIT #####

source ~/conf/git-completion.bash

green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

source ~/conf/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$purple\u$green\$(__git_ps1)$blue \W $ $reset"

alias gitstom="git checkout master"
alias gitnb="git pull origin master; git checkout -b $1"
alias gitsm="git add .; git commit -m \"#Squash me\""
alias gitlg="git lg1"
alias gitlg1="git lg1"
alias gitlg2="git lg2"
alias gitlg3="git lg3"
clone_from_github () {
    git clone https://github.com/$1/$2 ${3:-$2}
}
alias gitclo="clone_from_github"

#s3curl
alias s3curl="~/bin/s3curl.pl"
# example to display portion of a file:
# s3curl --id pint -- -s -H "Range: bytes=0-20000"  http://fh-provider-prod.s3.amazonaws.com/hotel/json/regular/provider_partition=ean/date_partition=2018-05-14-05-02-46/data.json.gz | gzip -d

##### PYENV  ######

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


##### JAVA ####

export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"


##### GO ####

export GOPATH="$HOME/golang"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

alias gofhrepo="cd $GOFHREPO"
alias goerr="errcheck -blank ./..."


#### OLD REDSHIFT ACCESS #####
export OLD_REDSHIFT_PWD  #useless
export OLD_REDSHIFT_HOST
export OLD_REDSHIFT_USER
export OLD_REDSHIFT_PORT
export OLD_REDSHIFT_DB
alias psql_redshift="psql -h $OLD_REDSHIFT_HOST -U $OLD_REDSHIFT_USER -p $OLD_REDSHIFT_PORT -d $OLD_REDSHIFT_DB -a"


#### LAKE REDSHIFT ACCESS #####
export REDSHIFT_PWD  #useless
export PGPASSWORD
export REDSHIFT_HOST
export REDSHIFT_USER
export REDSHIFT_PORT
export REDSHIFT_DB
alias psql_lake="psql -h $REDSHIFT_HOST -U $REDSHIFT_USER -p $REDSHIFT_PORT -d $REDSHIFT_DB -a"


#### AWS ACCESS ####
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_REGION

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# added by travis gem
[ -f /Users/Charpi/.travis/travis.sh ] && source /Users/Charpi/.travis/travis.sh

# Workaround for Apple having deprecated use of OpenSSL in favor of its own TLS and crypto lib
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"


############################################
# ADD SEPARATOR AND TIMESTAMP BETWEEN EACH COMMAND
# Modified from emilis bash prompt script
# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1
# Modified for Mac OS X by
# @corndogcomputer
# Updated with my own custom github prompt
###########################################
# Fill with minuses
# (this is recalculated every time the prompt is shown in function prompt_command):
fill="--- "
reset_style='\[\033[00m\]'
status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
# prompt_style=$reset_style
# command_style=$reset_style'\[\033[1;29m\]' # bold black

# Prompt variable:
export PS1="$status_style"'$fill \t\n'"$purple\u$green\$(__git_ps1)$blue \W $ $reset"
# Reset color for command output
# (this one is invoked every time before a command is executed):
trap 'echo -ne "\033[00m"' DEBUG

function prompt_command {
# create a $fill of all screen width minus the time string and a space:
let fillsize=${COLUMNS}-9
fill=""
while [ "$fillsize" -gt "0" ]
do
fill="-${fill}" # fill with underscores to work on
let fillsize=${fillsize}-1
done

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
bname=`basename "${PWD/$HOME/~}"`
echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
;;
*)
;;
esac
}

PROMPT_COMMAND=prompt_command
