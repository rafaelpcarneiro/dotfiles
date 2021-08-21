"===============================================================================
"                           Standard Configurations
"===============================================================================
syntax on
set bg=dark

" Tabs
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set nu

set nowrap 
set noswapfile
set nobackup


" Scroll pages being always centered - nice tip from TFL
set scrolloff=999

set incsearch



" Formatting paragraph -- needs the par program
set formatprg=par

hi LineNr  ctermfg=gray
hi Normal  ctermfg=255

" set parameters for the directory tree Netrw
let g:netrw_liststyle=0
let g:netrw_banner=0
let g:netrw_browse_split=3
let g:netrw_winsize = 25

set colorcolumn=81
"set textwidth=80
hi ColorColumn ctermbg=235



"===============================================================================
"                                    Mappings
"===============================================================================
"nnoremap <SPACE> <Nop>
let mapleader = "-"

nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :w<cr> :source $MYVIMRC<cr> :q<cr>
nnoremap <leader>sf :w<cr> :source %<cr>

nnoremap <leader>hf $:call MyHFill()<cr>
nnoremap <leader>cf 81\|d$

" Movements
nnoremap J 10j
nnoremap K 10k
nnoremap H 0
nnoremap L $

" inseert the line where you are above
nnoremap <leader>P 0v$dk$pjdd

"===============================================================================
"                                Abbreviations
"===============================================================================
"iabbrev ssig Rafael Polli carneiro 
 


"===============================================================================
"                                   Templates
"===============================================================================
" Vim syntax for my fakeNewsAnalysis repository  
autocmd BufRead,BufNewFile ~/fakeNewsAnalysis/*.[ch]
    \ source ~/fakeNewsAnalysis/pph_in_C/syntax.vim

" Templates
autocmd BufNewFile *.html :0read ~/.vim/ftplugin/html/template.html
autocmd BufNewFile *.pl   :0read ~/.vim/ftplugin/perl/template.pl
autocmd BufNewFile *.tex  :0read ~/.vim/ftplugin/latex/template.tex 

" Snippets
autocmd BufNewFile,BufRead *.tex source ~/.vim/ftplugin/latex/snippets.vim

" Settings
autocmd BufNewFile,BufRead *.tex source ~/.vim/ftplugin/latex/settings.vim


" My functions
function! MyHFill() 
    let counter = 80 - col('.')
    let mytext = repeat(" ", counter)
    let line = getline('.')
    call setline('.', strpart(line, 0, col('.')) . mytext)
endfunction

