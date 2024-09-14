"""""""""""""""""" vim 通用配置 """""""""""""""""""""
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

"""""" 函数标签跳转 """""""
" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

""""vim ctags 更新 ： F5 """""
"noremap <F5> <ESC>:!ctags -R *<CR>:set tags=./tags,./TAGS,tags,TAG<CR>
"" 或者
set tags=./tags,./TAGS,tags,TAG<CR>
set autochdir
noremap <F5> <ESC>:!ctags -R *<CR>
""""" 说明：
" 如果没有在~/.vimrc配置文件（或其他类似的配置文件）中添加 set tags=tags;set autochdir 这两个配置，只能从tags所在目录指定路径直接打开代码文件才管用。举个栗子：代码目录为： ~/code，某个代码文件的路径是：a/b/c.c，并且在目录~/code下执行ctags -R命令生成tags文件。这种情况下，在~/code目录使用命令：vim a/b/c.c打开文件，是可以使用Ctrl + ]找到函数定义的，
" 但是，如果先进入目录~/code/a/b，再打开文件vim c.c，这样就会找不到tag。使用上文第二种配置方法，当前目录找不到tags时候会递归向上一级目录查找，可以避免这个问题。
""""vim ctags 配置 end """""

"""""""""""""""""" vim 通用配置 end """""""""""""""""""""

""""""" 插件配置 """"""""""""
" 使用vim-plug添加插件
call plug#begin('~/.vim/plugged')
"" 添加YCM插件
Plug 'ycm-core/YouCompleteMe'
Plug 'preservim/nerdtree'
Plug 'kien/rainbow_parentheses.vim'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline' "主题插件，可以使得状态栏的颜色更加丰富"
Plug 'vim-airline/vim-airline-themes'
call plug#end()
""""""" 插件配置 end """"""""""""


"""""""""" 具体插件定制 """"""""""""

"" YCM 配置 """"""""""""""""""""""""
let g:ycm_global_ycm_extra_conf='~/.vim/YouCompleteMe/.ycm_extra_conf.py'
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1


""""vim-airline-themes""""""""""""""
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


""""" 文件树设置 NERDTreeToggle """"""""""""""""""""
" 通过F3键来开启和关闭NERDTree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

" 启动vim时自动打开NERDTree，并将光标放在Tree的Tag
" autocmd VimEnter * NERDTree

" 启动vim时自动打开NERDTree，并将光标放在vim打开的文件
" autocmd VimEnter * NERDTree | wincmd p

" 如果退出vim后只剩Tree的Tag的话，则自动退出Tree的Tag
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" 当打开文件时，如果 NERDTree 是唯一的窗口，则关闭它
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""" NERDTreeToggle end """"""""""""""""""""

""""" 文件保存时自动执行ctags
autocmd BufWritePost *.c,*.h,*.cpp,*.hpp silent! execute '!ctags -a -f ./tags -e -R ' . expand('<cword>')

"""" fzf 配置： 就可以使用 Ctrl + p 来快速打开文件了。
nnoremap <C-p> :Files<CR>

""""""" 插件配置 end """"""""""""
