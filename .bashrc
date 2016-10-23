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
alias start_vnc='x11vnc -display :0 -localhost -scale 1920x1080 -clip xinerama0 -scale_cursor 1'
alias grep='grep --color'
alias diff='diff --color=auto'
alias h='history'
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
PS1="\n\[\e[0;33m\][\!\[\e[0;33m\]]\[\e[0;36m\] \T \[\e[1;36m\][\[\e[1;34m\]\u@\H\[\e[1;36m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ "
#PS1="\n\[\e[1;36m\][\!\[\e[1;36m\]]\[\e[0;36m\] \T \[\e[1;36m\][\[\e[0;34m\]\u@\H\[\e[1;36m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ "
export VISUAL="vim"
export EDITOR="vim"

# Colors for less
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style molokai"
export LESS='-R '

# Colors for cat
alias ccat="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style molokai"

# Set grep color to green
export GREP_COLOR="0;32"

# Use solarized colors for ls and similar commands
eval `dircolors ~/.dir_colors/dircolors.256dark`
