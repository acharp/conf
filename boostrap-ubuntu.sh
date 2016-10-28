sudo apt-get update

sudo apt-get -y install git

cd ~

git clone https://github.com/acharp/conf.git

# Set up dotfiles
rm .bashrc
ln -s conf/.bashrc .bashrc
ln -s conf/.bash_profile .bashrc
ln -s conf/.tmux.conf .tmux.conf
ln -s conf/.vimrc .vimrc
ln -s conf/.gitignore_global .gitignore_global
cp .gitconfig ~/

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
