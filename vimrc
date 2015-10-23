" srozanc vim config file:
" 2015-09
 
" Set Hidden Option
set hidden
 
" Disable the swap file noise
set noswapfile
 
" Set our font:
set gfn=Courier_New:h9:cANSI
 
" Set syntax highlighting:
syntax enable
 
" Remove Toolbar (guioptions == go)
" T == toolbar && m == menu
set guioptions-=T
set guioptions-=m
 
" Intelligent Menu
set wildmenu
 
" GVIM Copy/Paste Friendly Macros:
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
 
" Add functionality for block navigation:
noremap <C-J> gj
noremap <C-K> gk
 
" Fix up backspace behaviour:
" Equiv to set backspace=2
set backspace=indent,eol,start
 
" Search as characters are entered:
set incsearch

" Don't redrew when executing macros:
set lazyredraw
 
" Treat files with no extension as conf files (for the purpose of colouring)
autocmd BufEnter * if &filetype == "" | setlocal ft=conf | endif
