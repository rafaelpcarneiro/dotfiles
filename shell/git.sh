#!/usr/bin/env bash

# Functions to synchronize github repository with my local machine,
# using ssh
gitsync () {
	git remote set-url origin "git@github.com:rafaelpcarneiro/$1.git"
}

gitclone () {
	git clone "git@github.com:rafaelpcarneiro/$1.git"
}
