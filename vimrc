syntax on
set nocompatible              " required
filetype off                  " required
set encoding=utf-8
set tabstop=4 
set shiftwidth=4 
set expandtab
set foldmethod=indent
hi Folded ctermbg=233
hi Folded ctermfg=241

"------------------------------ Mappings ------------------------------
let mapleader = "-"
nnoremap <leader>v :tabedit ~/.dotfiles/vimrc<cr>
nnoremap <leader>b :tabedit ~/.dotfiles/bashrc<cr>
nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>q :q<cr>
nnoremap <leader>e :e 

nnoremap <leader>s  :sp<cr>
nnoremap <leader><leader> :vsp<cr>

nnoremap <space>wk <c-w>k
nnoremap <space>wj <c-w>j
nnoremap <space>wl <c-w>l
nnoremap <space>wh <c-w>h
nnoremap <space>f za

"nnoremap <c-0> <c-w><    Not working 
"nnoremap <c-9> <c-w>>    Not working
nnoremap + <c-w>+
nnoremap = <c-w>-
au FileType vim nnoremap <leader>c :w<cr> :source %<cr> :q<cr>
"---------------------------------------------------------------------


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'gmarik/Vundle.vim'        " Pip like installer for vim
	Plugin 'vim-syntastic/syntastic'  " Syntax checking
	Plugin 'nvie/vim-flake8'          " Pep 8
	Plugin 'scrooloose/nerdtree'      " nerdtree
	"Plugin 'jistr/vim-nerdtree-tabs'  " nerdtree working with tabs
    "Plugin 'vim-airline/vim-airline'  " statusline
	"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " status bar
call vundle#end()            " required
filetype plugin indent on    " required

"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let python_highlight_all=1
au BufNewFile,BufRead *.py 
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
