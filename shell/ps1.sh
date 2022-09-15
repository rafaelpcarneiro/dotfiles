#!/usr/bin/env bash

print_ps1() {
	#|--- Color Scheme
	local _RED="\e[0;31m"
	local _PURPLE="\e[0;35m"
	local _GREEN="\e[0;32m"
	local _BLUE="\e[0;34m"
	local _CC="\e[m"

	#|--- variables
	local ps1=""

	local u=$(whoami)
	local h=$(cat /etc/hostname)
	local W=$(pwd|grep -o -P "/[^/]*$"|cut -c2-)
	[ $(pwd) = ${HOME} ] && W="~"

	local _git_repo=$(git rev-parse --is-inside-work-tree 2>/dev/null)
	local _jobs_running=$(jobs| grep "Running" |wc -l)


#|--- Printing ps1
	ps1="${_RED}["
	if [ ${_jobs_running} -gt 0 ]; then
		ps1+="${_BLUE}•Jobs ${_jobs_running} "
	fi

	if [ -n "${_git_repo}" ]; then
		ps1+="${_PURPLE}•GIT "
	fi

	ps1+="${_RED}${u}@${h} ${W}]${_CC}${_GREEN}\n┗▶ "

	echo -e "${ps1}"
}
PS1="\$(print_ps1)"
