#!/bin/bash
sudo add-apt-repository ppa:numix/ppa
sudo add-apt-repository ppa:ricotz/docky
sudo apt-get update
sudo apt-get install curl wget
sudo apt-get install numix-gtk-theme numix-icon-theme numix-icon-theme-circle numix-wallpaper-saucy
sudo apt-get install unity-tweak-tool
sudo apt-get install plank
sudo apt-get install guake
sudo apt-get install vim
sudo apt-get install git
sudo apt-get install ctags
sudo apt-get install cscope
sudo apt-get install clang 
sudo apt-get install clang-format-3.7 
sudo ln -s /usr/bin/clang-format-3.7 /usr/bin/clang-format
sudo apt-get install cmake 
sudo apt-get install python-dev 
sudo apt-get install php-pear
sudo apt-get install python-pip
sudo pear install PHP_CodeSniffer
sudo pip install https://github.com/Rykka/instant-rst.py/archive/master.zip
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cp ./.vimrc ~/.vimrc
cp -r ./colors ~/.vim/
cd ~/.vim/bundle
git clone git@github.com:Valloric/ListToggle.git
git clone git@github.com:scrooloose/nerdtree.git
git clone git@github.com:drwx/php-doc.vim.git
git clone git@github.com:scrooloose/syntastic.git
git clone git@github.com:vim-scripts/taglist.vim.git
git clone git@github.com:fatih/vim-go.git #需在vim中运行 :GoInstallBinaries
git clone git@github.com:Yggdroot/indentLine.git
git clone git@github.com:klen/python-mode.git
git clone git@github.com:scrooloose/nerdcommenter.git
git clone git@github.com:Rykka/riv.vim.git
git clone git@github.com:Rykka/InstantRst.git
git clone git@github.com:rhysd/vim-clang-format.git
git clone https://github.com/vim-airline/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes
git clone git://github.com/airblade/vim-gitgutter.git
git clone git@github.com:Valloric/YouCompleteMe.git && \
    cd ~/.vim/bundle/YouCompleteMe && \
        git submodule update --init --recursive && \
        ./install.py --clang-completer --gocode-completer --omnisharp-completer

git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool
