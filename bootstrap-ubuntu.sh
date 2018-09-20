#!/bin/bash

sudo apt-get update

# Set up dotfiles
rm ~/.bashrc
ln -s conf/.bashrc ~/.bashrc
ln -s conf/.bashrc ~/.bash_profile
ln -s conf/.tmux.conf ~/.tmux.conf
ln -s conf/.vimrc ~/.vimrc
ln -s conf/.gitignore_global ~/.gitignore_global
ln -s conf/.gitconfig ~/.gitconfig

# Fix tmux
cat .tmux.conf | grep -v "set-option -g default-command \"reattach-to-user-namespace bash\"" > tmux_tmp
mv tmux_tmp .tmux.conf

# Install Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Fix YouCompleteMe
sudo apt-get -y install build-essential cmake
sudo apt-get -y install python-dev python3-dev
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

# Python set up
sudo apt-get -y install python-pip
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
sudo pip install virtualenv

# Scala and sbt
sudo apt-get -y remove scala-library scala
sudo apt-get -y install scala
sudo apt-get -y install sbt

# Go
# TODO
# maybe : https://github.com/canha/golang-tools-install-script

cd ~
. .bashrc
