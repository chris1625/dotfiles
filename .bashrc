#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Random cowthink with fortune quote
#command fortune -a | fmt -80 -s | $(shuf -n 1 -e cowsay cowthink) -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n

# History settings
export HISTCONTROL="ignoreboth"
export HISTIGNORE="ls:cd:cd -:cd ~:pwd:exit:date:* --help:h *"

# completion for sudo
complete -cf sudo

alias ls='ls --color=auto'
alias ll='ls -alh'
alias lt='ls -alth'
alias grep='grep --color'
alias diff='diff --color=auto'
alias h='history'
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
PS1="\n\[\e[1;30m\][\!\[\e[1;30m\]]\[\e[0;36m\] \T \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ "
export VISUAL="vim"
export EDITOR="vim"

# Colors for less
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '

# Set grep color to green
export GREP_COLOR="1;32"
