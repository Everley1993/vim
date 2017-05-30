#!/bin/bash
brew install git
brew install ctags
brew install cscope
brew install cmake
brew install vim
cd /tmp/ && \
	wget http://pear.php.net/go-pear.phar && \
	php go-pear.phar && \
	ln -s /Users/li/pear/bin/pear /usr/local/bin/pear && \
	pear install PHP_CodeSniffer
brew install python && \
	pip install https://github.com/Rykka/instant-rst.py/archive/master.zip && \
    pip install requests
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cp ./.vimrc ~/.vimrc
cp -r ./colors ~/.vim/
cd ~/.vim/bundle
git clone https://github.com/Valloric/ListToggle.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/drwx/php-doc.vim.git
git clone https://github.com/scrooloose/syntastic.git
git clone https://github.com/vim-scripts/taglist.vim.git
git clone https://github.com/fatih/vim-go.git #需在vim中运行 :GoInstallBinaries
git clone https://github.com/Yggdroot/indentLine.git
git clone https://github.com/ianva/vim-youdao-translater.git
git clone https://github.com/klen/python-mode.git
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/Rykka/riv.vim.git
git clone https://github.com/Rykka/InstantRst.git
git clone https://github.com/rhysd/vim-clang-format.git
git clone https://github.com/vim-airline/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/plasticboy/vim-markdown.git
git clone https://github.com/godlygeek/tabular.git
git clone https://github.com/Chiel92/vim-autoformat.git
git clone https://github.com/iamcco/markdown-preview.vim.git
git clone https://github.com/iamcco/mathjax-support-for-mkdp.git
git clone https://github.com/Valloric/YouCompleteMe.git && \
    cd ~/.vim/bundle/YouCompleteMe && \
        git submodule update --init --recursive && \
        ./install.py --clang-completer --gocode-completer --omnisharp-completer

git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool
