# .bashrc

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# referenced in .bash_profile
prependpath() {
    if ! echo $PATH | grep -Eq "(^|:)$1($|:)"; then
        export PATH=$1:$PATH
    fi
}

# environment variables
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
export LESS="-R -i -P%f?m (%i of %m). - %lb/%L ?eEND:%Pb\%.$"

# shell options
shopt -s autocd
shopt -s checkwinsize
shopt -s histappend

# protect me from myself
alias mv='mv -i'
alias rm='rm -I'

# colours
alias grep='grep --color=auto'
eval $(dircolors $HOME/.dir_colors)
export EZA_COLORS="uu=3;2;0:gu=3;2;0:sc=0"

# ls -> eza
alias ls='eza --time=modified --no-user --git --group-directories-first'
alias ll='ls --no-permissions -lo'
alias la='ls -a'
alias lt='ls -snew'
alias lr='ls -R'

alias tree='tree -C --dirsfirst'

# more aliases
alias neofetch='fastfetch -l none'
alias cpk='hyprpicker -n' # -n gets rid of fancy formatting
alias wlc='wl-copy -n' # -n trims extra newline
alias wlp='wl-paste'
alias dcp='pwd | wlc'
alias open='xdg-open'

alias vim='nvim'

# print the given field of stdin
field() {
    awk -F "${2:- }" "{ print \$${1:-1} }"
}

# git aliases
alias gs='git status'
alias gd='git diff'
# open all modified files in git branch in vim
alias gim='vim -p $(git status | grep "modified:" | field 2)'

# only print exit code if not 0
bad_exit() {
    e=$?
    [ $e == 0 ] || echo "$e "
}

source $HOME/.git-prompt.sh

# colours for PS1
GREEN='\[\e[0;32m\]'
BOLD_BLUE='\[\e[1;34m\]'
DIM='\[\e[2m\]'
RESET='\[\e[0m\]'

PS1="${GREEN}\u@\h ${BOLD_BLUE}\W${DIM}\$(__git_ps1 ' (%s)') ${GREEN}\$(bad_exit)\$ ${RESET}"

# terminal window title
update_title() {
    echo -ne "\033]0;${USER}@${HOSTNAME} $(pwd | sed -e "s|^$HOME|~|g") ($(tput lines)x$(tput cols))\007"
}

PROMPT_COMMAND='update_title;'
trap 'update_title;' WINCH

# show all the terminal colours
cols() {
    for col in {0..255}; do
        tput setab $col
        echo -n "$col "
    done
    tput sgr0
    echo
}

# deno environment
. "$HOME/.deno/env"
