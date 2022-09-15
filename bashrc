#!/usr/bin/env bash
#
export DOTFILES="${HOME}/dotfiles"
export PATH=$PATH:~/.local/bin:~/.emacs.d/bin

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -FG'
alias gcc='gcc -Wall -Wextra  -Werror -ansi -pedantic -O3'
alias jailfox="firejail --private firefox -no-remote"

source ${DOTFILES}/shell/ps1.sh
source ${DOTFILES}/shell/git.sh
source ${DOTFILES}/shell/titanio_cluster.sh
source ${DOTFILES}/shell/pdftopng.sh



# urxvt terminal fonts and specs
xrdb ~/.Xresources

# Set twitter credentials as environment variables
if [ -f ${HOME}/.twitter_credentials.sh ]; then
   source ${HOME}/.twitter_credentials.sh
fi


# |--- Google Cloud API
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rafael/gcloud/google-cloud-sdk/path.bash.inc' ]; then
   . '/home/rafael/gcloud/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/rafael/gcloud/google-cloud-sdk/completion.bash.inc' ]; then
   . '/home/rafael/gcloud/google-cloud-sdk/completion.bash.inc';
fi
