call pathogen#infect()
filetype plugin indent on
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

set number
set cursorline
set shiftwidth=4
set tabstop=4
set expandtab
syntax enable
colorscheme monokai
set nobackup
set backspace=indent,eol,start

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

" F5运行脚本
map <F5> <ESC>: call RunThisScript() <CR>

" 设置NerdTree
map <F3> :NERDTreeToggle<CR>

" 设置php-doc
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 

" 设置ctags
map <C-y> <ESC>:tnext<CR>

" 标签页切换
map <F7> <ESC>:tabp<CR>
map <F8> <ESC>:tabn<CR>

" 用空格替换tab
map <C-b> <ESC>:%s/\t/    /g<CR>

" 有道翻译
map <C-l> <Esc>:Ydc 
noremap <leader>yd :Yde<CR>

" omni补全
imap <C-k> <C-x><C-o>

" taglist
let Tlist_Show_One_File=1    "只显示当前文件的tags
let Tlist_WinWidth=40        "设置taglist宽度
let Tlist_Exit_OnlyWindow=1  "tagList窗口是最后一个窗口，则退出Vim
let Tlist_Use_Right_Window=1 "在Vim窗口右侧显示taglist窗口
