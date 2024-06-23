#--------------------------------------------------------------------------------
# Usefull Programs 
#  - https://github.com/hackerb9/mktrans :: mk image's background transparent
#--------------------------------------------------------------------------------
 
#--------------------------------------------------------------------------------
export DOTFILES=$HOME/.dotfiles
export PATH=$PATH:$DOTFILES/lib_bash
export WORKON_HOME=~/.virtualenvs

source ${DOTFILES}/tokens.conf
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
#--------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
merge_pdfs(){
    gs -dBATCH \
        -dNOPAUSE \
        -q \
        -sDEVICE=pdfwrite \
        -dPDFSETTINGS=/prepress \
        -sOutputFile=merged.pdf $@
}
#-------------------------------------------------------------------------------
