##### GENERAL #####

export PAGER="less"

export EDITOR=/usr/bin/vim

alias ..="cd .."
alias la="ls -a"

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

# Make CLI works as Vim => Will work when switching to zsh
#bindkey -v
#bindkey -M viins 'jk' vi-cmd-mode

# Make CLI works as Vim => when using bash
set -o vi
bind -m vi-command ".":insert-last-argument
bind -m vi-insert "\C-l.":clear-screen
bind -m vi-insert "\C-a.":beginning-of-line
bind -m vi-insert "\C-e.":end-of-line
bind -m vi-insert "\C-w.":backward-kill-word


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
alias gitsm="git add .; git commit -m \"Squash me\""


##### PYENV  ######

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


##### GO ####

export GOPATH="$HOME/golang"
export PATH="$PATH:$GOPATH/bin"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:$GOROOT/bin"


#### REDSHIFT ACCESS #####
export PGPASSWORD
export REDSHIFT_HOST
export REDSHIFT_USER
export REDSHIFT_PORT
export REDSHIFT_SCHEMA
alias psql_redshift="psql -h $REDSHIFT_HOST -U $REDSHIFT_USER -p $REDSHIFT_PORT -d $REDSHIFT_SCHEMA -a"


#### AWS ACCESS ####
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_REGION
