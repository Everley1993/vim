call pathogen#infect()
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

function RunThisScript() 
    let file_name = expand("%:p")
    let file_ext = expand("%:e")
    let file_cmd = ""
 
    "python 直接调用
    if file_ext == "py"
        let file_cmd = '/usr/bin/python'
        let file_args = ' ' . file_name
    "c 需要提取第一行的编译参数
    "如，当需要引入第三方库(以mysql为例)时，则在第一行添加: //-lmysqlclient -L/usr/local/mysql/include
    "文件中则可直接　#include <mysql/mysql.h>
    elseif file_ext == "c"
        let file_first_line = getline(1)
        let file_arg = ""
        if strpart(file_first_line, 0, 2) == '//'
            let file_arg = strpart(file_first_line, 2) "提取参数
        endif
        let file_output_file = strpart(file_name, 0, strridx(file_name, '.c')) 
        let file_args = ' -o '. file_output_file .' '.  file_name . ' '. file_arg .' && '. file_output_file "将参数附加到编译命令之后
        let file_cmd = '/usr/bin/cc'
    "php 直接调用
    elseif file_ext == "php"
        let file_cmd = "/usr/bin/php" "php执行路径
        let file_args = ' -f '. file_name
    "perl 直接调用
    elseif file_ext == "perl" || file_ext == "pl"
        let file_cmd = "/usr/bin/perl"
        let file_args = " ". file_name
    "erlang 默认调用 main 函数, 可以确保 escript 和 noshell/shell 执行时一致
    elseif file_ext == "erl"
        let file_output_file = strpart(expand("%"), 0, stridx(expand("%"), ".erl"))
        let file_cmd = "/usr/bin/erlc"
        let file_args = file_output_file .".". file_ext ." ; /usr/bin/erl -noshell -s ". file_output_file . " main  -s init stop"
    "java 先调用 javac，再调用java
    elseif file_ext == "java"
        let file_output_file = strpart(expand("%"), 0, stridx(expand("%"), ".java"))
        let file_cmd = 'javac'
        let file_args = file_name ." && java ". file_output_file
    elseif file_ext == "go"
        let file_cmd = "go"
        let file_args = " run ". file_name
    else
        echo "错误: 没有任何编译器匹配此文件类型, 请确认您的文件扩展名!"
    endif
 
    if file_cmd != ""
        if ! executable(file_cmd)
            echo file_cmd
            echo "The executable file to compile ". file_ext . " type files."
        else
            let cmd = "! ". file_cmd . ' ' . file_args
            "echo "执行命令: ". cmd
            exec cmd 
        endif
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F5运行脚本
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> <ESC>: call RunThisScript() <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F3> :NERDTreeToggle<CR>

" php-doc
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-y> <ESC>:tnext<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 标签页切换
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F7> <ESC>:tabp<CR>
map <F8> <ESC>:tabn<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 用空格替换tab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-b> <ESC>:%s/\t/    /g<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 有道翻译
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t <Esc>:Ydc 
noremap <leader>yd :Yde<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 格式化php代码
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <c-f> <Esc>:%!phpcbf<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" omni
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-a> <C-x><C-o>
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd Filetype c   set omnifunc=ccomplete#Complete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1    "只显示当前文件的tags
let Tlist_WinWidth=40        "设置taglist宽度
let Tlist_Exit_OnlyWindow=1  "tagList窗口是最后一个窗口，则退出Vim
let Tlist_Use_Right_Window=1 "在Vim窗口右侧显示taglist窗口

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 使用tags文件
let g:ycm_collect_identifiers_from_tag_files = 1 
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python-mode 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open = 1
let g:pymode_rope = 0 
map <c-r> <Esc>:PymodeLintAuto<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"<leader>cc         注释当前行和选中行  
"<leader>c<空格>    如果被选区域有部分被注释，则对被选区域执行取消注释操作，其它情况执行反转注释操作  
"<leader>cm         对被选区域用`一对`注释符进行注释，前面的注释对每一行都会添加注释  
"<leader>ci         执行反转注释操作，选中区域注释部分取消注释，非注释部分添加注释  
"<leader>cu         取消注释  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" InstantRst 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
":InstantRst
":StopInstantRst

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" golint 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clang-format 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType c,h,cpp,objc ClangFormatAutoEnable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitgutter 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F7> :GitGutterLineHighlightsToggle<CR>
