execute pathogen#infect()
syntax on
filetype plugin indent on
set number
set cursorline
set shiftwidth=4
set tabstop=4
set expandtab
syntax enable
colorscheme monokai
set nobackup
set backspace=indent,eol,start
let mapleader = ","
set encoding=utf-8
set wrap

" Plugin  - neocomplete
" Install - git clone https://github.com/Shougo/neocomplete.vim.git ~/.vim/bundle/neocomplete.vim
"         - ubuntu: sudo apt-get install vim-nox
"         - mac: brew cask install macvim --with-cscope --with-lua
" Notice  - :set paste would disable neocomplete
let g:neocomplete#enable_at_startup = 1

" Plugin  - Ack
" Install - git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
"         - sudo apt-get install ack-grep
" Usage   - :Ack [options] {pattern} [{directories}]
" Doc     - https://beyondgrep.com/documentation/

" Plugin  - NERDTree
" Install - git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
map <F3> :NERDTreeToggle<CR>

" Plugin  - NERD Commenter
" Install - git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
" Usage   - :help nerdcommenter

" Plugin  - ctrlp
" Install - git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp
" Usage   - :CtrlP

" Plugin  - vim-airline
" Install - git clone https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline

" Plugin  - Indent Guides
" Install - git clone https://github.com/nathanaelkane/vim-indent-guides.git  ~/.vim/bundle/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0

" Plugin  - vim-go
" Install - git clone https://github.com/fatih/vim-go.git  ~/.vim/bundle/vim-go
"         - :GoInstallBinaries

" Plugin  - jedi-vim
" Install - git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" Plugin  - Vim Markdown
" Install - git clone https://github.com/godlygeek/tabular.git ~/.vim/bundle/tabular
" Install - git clone https://github.com/plasticboy/vim-markdown.git ~/.vim/bundle/vim-markdown
" Usage   - :MarkdownPreview
"         - :MarkdownPreviewStop
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_conceal = 0

" Plugin  - SingleCompile
" Install - git clone https://github.com/xuhdev/SingleCompile.git ~/.vim/bundle/SingleCompile
map <F5> <ESC>:SCCompileRun<CR>

" Plugin  - Tagbar
" Install - git clone https://github.com/majutsushi/tagbar.git ~/.vim/bundle/tagbar
nmap <F8> :TagbarToggle<CR>

" replace space with tabs
map <C-b> <ESC>:%s/\t/    /g<CR>

" auto delete space after line
function RemoveSpaces()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction
autocmd BufWritePre,FileAppendPre,FileWritePre,FilterWritePre * :call RemoveSpaces()
