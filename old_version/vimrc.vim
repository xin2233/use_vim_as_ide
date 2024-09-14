"""""""""""""""""" vim 通用配置 """""""""""""""""""""
"""配色""""
colorscheme desert

""""vim ctags 自动更新"""""
noremap <F6> <ESC>:!ctags -R *<CR>:set tags=./tags,./TAGS,tags,TAG<CR>

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" 配色方案
set background=dark
colorscheme solarized
"colorscheme molokai
"colorscheme phd

" 禁止光标闪烁
"set gcr=a:block-blinkon0
" 禁止显示滚动条
"set guioptions-=l
"set guioptions-=L
"set guioptions-=r
"set guioptions-=R
" 禁止显示菜单和工具条
"set guioptions-=m
"set guioptions-=T

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

"""""""""""""""""" vim 通用配置 end """""""""""""""""""""


""""""""""""""""""""""' vim plug 插件配置 """"""""""""""""""""""""""""""
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes


" On-demand loading， nerdtree 文件夹视图
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

"  这个好像是个搜索插件，可以快速的找到文件
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

Plug 'majutsushi/tagbar'

"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"Plug 'valloric/youcompleteme'  -- failed  需要联网，在离线环境不好配置

Plug 'vim-airline/vim-airline' "主题插件，可以使得状态栏的颜色更加丰富"
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

""""""""""""""""""""""' vim plug 插件配置 end """""""""""""""""""""""""""""


"""""""""" 具体插件定制 """"""""""""

""""""""""""vim-airline-themes""""""""""""""
"其中 vim-airline-themes 是主题插件，可以使得状态栏的颜色更加丰富""""""""'
set laststatus=2  								" 永远显示状态栏
let g:airline_powerline_fonts = 1  				" 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 	" 显示窗口tab和buffer
let g:airline_theme='moloai'  					" murmur配色不错

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'


""""""""""""" 文件树设置 NERDTreeToggle """"""""""""""""""""
" 通过F3键来开启和关闭NERDTree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

" 启动vim时自动打开NERDTree，并将光标放在Tree的Tag
autocmd VimEnter * NERDTree

" 启动vim时自动打开NERDTree，并将光标放在vim打开的文件
autocmd VimEnter * NERDTree | wincmd p

" 如果退出vim后只剩Tree的Tag的话，则自动退出Tree的Tag
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" 当打开文件时，如果 NERDTree 是唯一的窗口，则关闭它
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""" NERDTreeToggle end """"""""""""""""""""


"""""""""" Taglist (ctags)""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1  "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1  "如果taglist窗口是最后一个窗口，则退出vim

let Tlist_Auto_Open=1    "在启动VIM后，自动打开taglist窗口

"let Tlist_Use_SingleClick= 1    " 缺省情况下，在双击一个tag时，才会跳到该tag定义的位置

"let Tlist_Process_File_Always=1  "taglist始终解析文件中的tag，不管taglist窗口有没有打开

"let Tlist_File_Fold_Auto_Close=1 "同时显示多个文件中的tag时，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来
"""""""""""""""""""end """""""""""""""""""""""""""

"""""""""""""" cscope 配置 """"""""""""""""""""""""""""
" 指定了执行cscpoe的命令
" csto 值决定了:cstag执行查找的顺序。为0则cscope数据将会被优先查找，然后才会查找tag文件。为1，则查找顺序相反。默认值是0
" cscopequickfix指定了是否使用quickfix窗口来显示cscope的结果

if has("cscope")
    set csprg=/usr/bin/cscope 
    set csto=0  " cscope数据将会被优先查找
    set nocsverb
    
    " 添加当前目录下的数据库
    if filereadable("cscope.out")       
        cs add cscope.out
    " 添加环境变量中指定的数据库
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    
    set cscopequickfix=s-,g-,c-,f-,t-,d-,i-,e-,a-
    
    " 快捷键映射
    " leader : default \
    nnoremap <leader>fs :cs find s <c-r>=expand("<cword>")<cr><cr>:copen<cr>  " 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
    nnoremap <leader>fg :cs find g <c-r>=expand("<cword>")<cr><cr>:copen<cr>  " 查找函数、宏、枚举等定义的位置
    nnoremap <leader>fd :cs find d <c-r>=expand("<cword>")<cr><cr>:copen<cr>  " 查找本函数调用的函数       
    nnoremap <leader>fc :cs find c <c-r>=expand("<cword>")<cr><cr>:copen<cr>  " 查找调用本函数的函数
    nnoremap <leader>ft :cs find t <c-r>=expand("<cword>")<cr><cr>:copen<cr>  " 查找指定的字符串
    nnoremap <leader>fe :cs find e <c-r>=expand("<cword>")<cr><cr>:copen<cr>  " 查找egrep模式，相当于egrep功能，但查找速度快多了
    nnoremap <leader>ff :cs find f <c-r>=expand("<cfile>")<cr><cr>:copen<cr>  " 查找并打开文件，类似vim的find功能
    nnoremap <leader>fi :cs find i <c-r>=expand("<cfile>")<cr><cr>:copen<cr>  " 查找包含本文件的文件
     
    nnoremap <c-j> :cnext<cr>      " 切换至下一个cscopequickfix的搜索结果 映射为 ctrl+j            
    nnoremap <c-k> :cprev<cr>      " 切换至上一个cscopequickfix的搜索结果 映射为 ctrl+k                                                                  
                                                       
    nnoremap <leader>t :copen<cr>  " 打开cscopequickfix窗口
    autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
endif
"""""""""""""" cscope 配置 end """"""""""""""""""""""""""""


""""""""""""""""""""" tagbar 定制 """"""""""""""""""""""""
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
nnoremap <Leader>ilt :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

""""""""""""""""""""" tagbar 定制 end """"""""""""""""""""""""

"""""""""" 具体插件定制 end """"""""""""


