"===============================================================================
"                           Standard Configurations
"===============================================================================
syntax on
" t_Co forces vim to work with a pallete of colors within 256 shades of colors
set t_Co=256
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

set foldmethod=marker

" Formatting paragraph -- needs the par program
set formatprg=fmt

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
hi Folded      ctermbg=none ctermfg=75


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

" insert the line where you are above
nnoremap <leader>P 0v$dk$pjdd

" Show file's path
nnoremap <leader>pwd :echo expand('%:p')<cr>

"===============================================================================
"                                Abbreviations
"===============================================================================
"iabbrev ssig Rafael Polli carneiro 
 


"===============================================================================
"                         sourcing file configurations
"===============================================================================
" Vim syntax for my fakeNewsAnalysis repository  
autocmd BufRead,BufNewFile ~/fakeNewsAnalysis/pph_in_C_v03/*.[ch]
    \ source ~/fakeNewsAnalysis/pph_in_C_v03/syntax.vim

" LaTeX
autocmd BufNewFile         *.tex :0read ~/.vim/latex/template.tex 
autocmd BufNewFile,BufRead *.tex source ~/.vim/latex/displayLatexNicely.vim
autocmd BufNewFile,BufRead *.tex source ~/.vim/latex/snippets.vim

" HTML
autocmd BufNewFile         *.html :0read ~/.vim/html/template.html
autocmd BufNewFile,BufRead *.html source ~/.vim/html/snippets.vim

" Perl (need some changes!)
autocmd BufNewFile         *.pl   :0read ~/.vim/perl/template.pl

" Python
autocmd BufNewFile         *.py   :0read ~/.vim/py/template.vim
autocmd BufNewFile,BufRead *.py   source ~/.vim/py/config.vim



" My functions
function! MyHFill() 
    let counter = 80 - col('.')
    let mytext = repeat(" ", counter)
    let line = getline('.')
    call setline('.', strpart(line, 0, col('.')) . mytext)
endfunction

