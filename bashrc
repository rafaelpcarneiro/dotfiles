# vim: set foldmethod=marker:
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -FG'

alias gcc='gcc -Wall -Wextra  -Werror -ansi -pedantic -O3'

alias jailfox="firejail --private firefox -no-remote"

#|--- PS1 config {{{
print_ps1() {
	#|--- local colors {{{2
	local _black="\e[0;30m"
	local _red="\e[0;31m"
	local _green="\e[0;32m"
	local _brown="\e[0;33m"
	local _blue="\e[0;34m"
	local _purple="\e[0;35m"
	local _cyan="\e[0;36m"
	local _light_gray="\e[0;37m"

	local _dark_gray="\e[1;30m"
	local _light_red="\e[1;31m"
	local _light_green="\e[1;32m"
	local _yellow="\e[1;33m"
	local _light_blue="\e[1;34m"
	local _light_purple="\e[1;35m"
	local _light_cyan="\e[1;36m"

	local _white="\e[1;37m"

	local _close_color="\e[m"

	# Background color
	local _bggreen="\e[42m"
	local _bgyellow="\e[43m"
	#2}}}

	#|--- User, hostname and parent directory {{{2
	local _u=`whoami`
	local _h=`cat /etc/hostname`
	local _W=`pwd|grep -o -P "/[^/]*$"|cut -c2-`
	test "$_W" = "$_u" && _W="~"
	#2}}}

	#|--- Checking the git branch in use {{{2
	local gitBranch=`git branch -l 2>&1|grep -o -P "fatal"`
	if test -z "$gitBranch"
	then
		local whichBranch=`git branch -l 2>&1|grep -P "^\*"|grep -o -P "[\d\w]*"`
		gitBranch="--""$_light_purple""[Git branch: $whichBranch]""$_close_color"
	else
		gitBranch="NULL"
	fi
	#2}}}

	#|--- Checking Jobs {{{
	local _jobs=`jobs|wc -l`
	#}}}

	#|--- Printing ps1 {{{2
	#local __ps1="┏"

	local __ps1="$_red""[$_u@$_h $_W]""$_close_color"

	if [ "$gitBranch" != "NULL" ]
	then
		__ps1+="$gitBranch"
	fi

	if [ $_jobs -gt 0 ]
	then
		__ps1+="$_light_cyan""--[!Jobs=$_jobs]""$_close_color"
	fi

	__ps1+="\n┗▶$ "

	echo -e "$__ps1"
	#2}}}
}
PS1="\$(print_ps1)"
# }}}


# Function to synchronize github repository with my local machine, using
# ssh
gitsync () {
	git remote add     origin "https://github.com/rafaelpcarneiro/$1.git"
	git remote set-url origin "git@github.com:rafaelpcarneiro/$1.git"
}

gitclone () {
	git clone "git@github.com:rafaelpcarneiro/$1.git"
}

# Set twitter credentials as environment variables
source .twitter_credentials.sh

##|--- Start screenfetch. When tmux is called screenfetch is ignored {{{1
#if [ -z $TERM_PROGRAM ] || [ $TERM_PROGRAM != "tmux" ]
#then
#	sleep 0.2s
#	screenfetch
#fi
## 1}}}

# Set .local at PATH
export PATH=$PATH:~/.local/bin

# titanio_cluster on/off + some functions {{{1
titanio_cluster () {
    if [ $# -eq 0 ]; then
        echo "Argument empty is not valid. It must have as arguments the values (on/off)"
    else
        if [ $1 = "on" ]; then
            echo "Connecting to the Titanio cluster using IPV4"
            ssh -fN -L 9998:172.17.10.11:22 rafael.carneiro@hpc.ufabc.edu.br -4
            ssh -p 9998 rafael.carneiro@localhost  -4

        elif [ $1 = "off" ]; then
            echo "Disconnecting from the Titanio cluster..."
            local tunel_port_process=` netstat -tulpn |grep 9998 |grep -o -P "\d+/ssh"|cut -d '/' -f 1`
            kill $tunel_port_process
            echo "Disconnected..."
            echo ""
        else
            echo "Arguments valid are: on/off"
        fi
    fi
}
#1}}}

# Set terminal font to be for math or programming {{{1
mathfont () {
    local regular_font="xft:JuliaMono:style=Regular:pixelsize=18:antialias=true"
    local bold_font="xft:JuliaMono:style=Bold:pixelsize=18:antialias=true"
    local italic_font="xft:DejaVu Sans Mono:style=Italic:pixelsize=18:antialias=true"

    sed "s/<REGULAR_FONT>/$regular_font/" \
        ~/dotfiles/Xresources.template > ~/.Xresources

    sed -i "s/<BOLD_FONT>/$bold_font/"     ~/.Xresources
    sed -i "s/<ITALIC_FONT>/$italic_font/" ~/.Xresources

    xrdb ~/.Xresources
}

hackfont () {
    local regular_font="xft:Hack Nerd Font Mono:style=Regular:pixelsize=17:antialias=true"
    local bold_font="xft:Hack Nerd Font Mono:style=Bold:pixelsize=17:antialias=true"
    local italic_font="xft:Hack Nerd Font Mono:style=Italic:pixelsize=17:antialias=true"

    sed "s/<REGULAR_FONT>/$regular_font/" \
        ~/dotfiles/Xresources.template > ~/.Xresources

    sed -i "s/<BOLD_FONT>/$bold_font/"     ~/.Xresources
    sed -i "s/<ITALIC_FONT>/$italic_font/" ~/.Xresources

    xrdb ~/.Xresources
}
# 1}}}
