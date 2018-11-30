" Requirements - curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.local/share/nvim/plugged')
" Plugin       - deoplete.nvim
" Repository   - https://github.com/Shougo/deoplete.nvim
" Requirements - sudo pip3 install neovim
"              - git clone https://github.com/neovim/python-client.git && cd python-client && sudo pip3 install .
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Plugin       - vim-go
" Repository   - https://github.com/fatih/vim-go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Plugin       - deoplete-go
" Repository   - https://github.com/zchee/deoplete-go
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Plugin       - deoplete-jedi
" Repository   - https://github.com/zchee/deoplete-jedi
" Requirements - sudo pip3 install jedi
Plug 'zchee/deoplete-jedi'

" Plugin       - deoplete-ternjs
" Repository   - https://github.com/carlitux/deoplete-ternjs
" Requirements - sudo npm install -g tern
Plug 'carlitux/deoplete-ternjs'

" Plugin       - ack
" Repository   - https://github.com/mileszs/ack.vim
" Usage        - :Ack [options] {pattern} [{directories}]
Plug 'mileszs/ack.vim'

" Plugin       - nerdtree
" Repository   - https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'

" Plugin       - nerdcommenter
" Repository   - https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'

" Plugin       - ctrlp.vim
" Repository   - https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" Plugin       - airline
" Repository   - https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" Plugin       - vim-indent-guides
" Repository   - https://github.com/nathanaelkane/vim-indent-guides
Plug 'nathanaelkane/vim-indent-guides'

" Plugin       - tabular
" Repository   - https://github.com/godlygeek/tabular
Plug 'godlygeek/tabular'

" Plugin       - vim-markdown
" Repository   - https://github.com/plasticboy/vim-markdown
" Usage        - :MarkdownPreview
"              - :MarkdownPreviewStop
"              - :TableFormat
Plug 'plasticboy/vim-markdown'

" Plugin       - SingleCompile
" Repository   - https://github.com/xuhdev/SingleCompile
Plug 'xuhdev/SingleCompile'

" Plugin       - tagbar
" Repository   - https://github.com/majutsushi/tagbar
" Requirements - ubuntu - sudo apt-get install ctags
"              - mac    - brew install ctags
Plug 'majutsushi/tagbar'

" Plugin       - syntastic
" Repository   - https://github.com/vim-syntastic/syntastic
" Requirements - python - sudo pip3 install flake8
"                js     - sudo npm install -g eslint
" Usage        - :SyntasticInfo see syntastic's idea of available checkers
Plug 'vim-syntastic/syntastic'

" Plugin       - vim-autoformat
" Repository   - https://github.com/Chiel92/vim-autoformat
" Requirements - python           - sudo pip3 install yapf
"                js/css/html/json - sudo npm install -g js-beautify
"                typescript       - sudo npm install -g typescript-formatter
"                shell            - go get -u mvdan.cc/sh/cmd/shfmt
Plug 'Chiel92/vim-autoformat'

" Plugin       - vim-colorschemes
" Repository   - https://github.com/flazz/vim-colorschemes
Plug 'flazz/vim-colorschemes'
call plug#end()

" basic
syntax on
filetype plugin indent on
set number
set cursorline
set shiftwidth=4
set tabstop=4
set expandtab
syntax enable
set nobackup
set backspace=indent,eol,start
let mapleader = ","
set encoding=utf-8
set wrap
autocmd FileType html,xhtml,xml,css,javascript setlocal expandtab shiftwidth=2 tabstop=2

" deoplete.nvim
let g:deoplete#enable_at_startup = 1

" nerdtree
map <F3> :NERDTreeToggle<CR>

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_conceal = 0

" SingleCompile
map <F5> <ESC>:SCCompileRun<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pep8']
let g:syntastic_go_checkers = ['gofmt']
let g:syntastic_java_checkers = []

" vim-autoformat
au BufWrite * :Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatter_yapf_style = 'pep8'

" vim-colorschemes
colorscheme monokai

" replace space with tabs
map <C-b> <ESC>:%s/\t/    /g<CR>

" auto delete space after line
function RemoveSpaces()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction
autocmd BufWritePre,FileAppendPre,FileWritePre,FilterWritePre * :call RemoveSpaces()
