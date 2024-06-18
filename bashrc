export WORKON_HOME=~/.virtualenvs

source ${DOTFILES}/tokens.conf
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

#-------------------------------------------------------------------------------
merge_pdfs(){
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=merged.pdf $@
}
