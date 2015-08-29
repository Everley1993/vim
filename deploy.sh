#!/bin/bash
sudo apt-get install ctags
sudo apt-get install cscope
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
git clone git@github.com:ianva/vim-youdao-translater.git
git clone git@github.com:Valloric/YouCompleteMe.git && \
    cd ~/.vim/bundle/YouCompleteMe && \
        ./install.sh --clang-completer --gocode-completer --omnisharp-completer
