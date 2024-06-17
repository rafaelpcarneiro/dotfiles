export WORKON_HOME=~/.virtualenvs

source ${DOTFILES}/tokens.conf
merge_pdfs(){
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=merged.pdf $@
}
