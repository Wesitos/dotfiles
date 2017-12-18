#!/bin/bash

export BASH_PROFILE_RUN=1

if [[ -f "${HOME}/.path" ]]; then
	source "${HOME}/.path"
fi

# Load bashrc
if [[ -f "${HOME}/.bashrc" ]]; then
	  source "${HOME}/.bashrc"
fi

# append to the history file, don't overwrite it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell
