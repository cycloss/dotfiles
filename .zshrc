
# Add applications (where .appimage files are stored) to path
if [[ $OSTYPE = linux-gnu ]]; then
  PATH=$PATH:~/Applications
fi

# To add more to path simply add `:<dir>` to the end
export PATH=$PATH:"$HOME/.pub-cache/bin"

export ZSH_CUSTOM_DIR="$HOME/.zsh_custom"
export ABBR_USER_ABBREVIATIONS_FILE=$ZSH_CUSTOM_DIR/abbrs.zsh

# plugins
source $ZSH_CUSTOM_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM_DIR/functions.zsh
source $ZSH_CUSTOM_DIR/prompt.zsh
source $ZSH_CUSTOM_DIR/aliases.zsh
source $ZSH_CUSTOM_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSH_CUSTOM_DIR/zsh-abbr/zsh-abbr.zsh


# variables
export EDITOR="nano"
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

setopt SHARE_HISTORY # immediately append to history and don't wait til shell closes (INC_APPEND_HISTORY), AND import history commands into all sessions
setopt HIST_IGNORE_ALL_DUPS # removes old duplicates of the line and keeps the new one even if lines are not
setopt HIST_IGNORE_SPACE # if command starts with a space, omit it (for security)

# Enable pearl regex support
setopt RE_MATCH_PCRE

unsetopt LIST_BEEP # do not beep on tab complete

autoload -Uz vcs_info
autoload -Uz zcalc # enable calculator
autoload -Uz colors && colors

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor # loads nearest color to hexes if terminal emulator doesn't support true color

# new lines before and after commands

preexec() {
  echo
}

setWindowTitle() {
    echo -ne "\e]1;$USER@$HOST\a"
}

precmd() {
  setWindowTitle
  echo
}


# used for pathauto suggestions
# must compinit for completion (tabbed) suggestions to work
autoload -Uz compinit && compinit
ZSH_AUTOSUGGEST_STRATEGY=(history)
_comp_options+=(globdots)

# case insensitive tab auto complete (directories) only if there is no case sensitive match
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# tab when line empty shows dirs
first-tab() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="./"
        CURSOR=2
        zle list-choices
    else
        zle expand-or-complete
    fi
}
setopt auto_cd

zle -N first-tab
bindkey '^I' first-tab

setopt autopushd # auto push directories onto `dirs` stack
setopt pushdignoredups # do not push dups onto dir stack

# https://linux.die.net/man/1/zshzle for binding shortcuts
# `read` in terminal 

# history substring search seems to work differently on macos and linux
if [[ $OSTYPE == darwin* ]]; then
  # left and right with cmd j and l
  bindkey "^[^[[C" forward-word
  bindkey "^[^[[D" backward-word
  bindkey "^[[C" forward-char
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
else
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  # left and right with ctl j and l
  bindkey "\e[1;5C" forward-word
  bindkey "\e[1;5D" backward-word
  
  # must unbind keys which use ^X as prefix to be able
  # found with bindkey | grep -i '\^X'
  # to then set KEYTIMEOUT to prevent delay on cut
  bindkey -r "^X^B"
  bindkey -r "^X^F"
  bindkey -r "^X^J"
  bindkey -r "^X^K"
  bindkey -r "^X^N"
  bindkey -r "^X^O"
  bindkey -r "^X^R"
  bindkey -r "^X^U"
  bindkey -r "^X^V"
  bindkey -r "^X^X"
  bindkey -r "^X*" 
  bindkey -r "^X=" 
  bindkey -r "^X?" 
  bindkey -r "^XC" 
  bindkey -r "^XG" 
  bindkey -r "^Xa" 
  bindkey -r "^Xc" 
  bindkey -r "^Xd" 
  bindkey -r "^Xe" 
  bindkey -r "^Xg" 
  bindkey -r "^Xh" 
  bindkey -r "^Xm" 
  bindkey -r "^Xn" 
  bindkey -r "^Xr" 
  bindkey -r "^Xs" 
  bindkey -r "^Xt" 
  bindkey -r "^Xu" 
  bindkey -r "^X~" 

  bindkey "^X" kill-whole-line
  KEYTIMEOUT=1

  # for paste
  bindkey -r "^P"
  bindkey "^P" yank

  # for clear
  bindkey -r "^R"
  bindkey "^R" clear-screen
fi


# syntax highlighting tweaks
typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main regexp)

ZSH_HIGHLIGHT_STYLES[builtin]='fg=#97FEA4'
ZSH_HIGHLIGHT_STYLES[function]='fg=#97FEA4'
ZSH_HIGHLIGHT_STYLES[command]='fg=#97FEA4'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#97FEA4'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#79A070'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#79A070'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#F0776D'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#F0776D'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#FB649F'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=white'
ZSH_HIGHLIGHT_STYLES[default]='fg=#7EBDB3'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#F0776D'

if [[ $OSTYPE == darwin* ]]; then
  ZSH_HIGHLIGHT_REGEXP=('^[[:blank:][:space:]]*('${(j:|:)${(k)ABBR_REGULAR_USER_ABBREVIATIONS}}')$' fg=#97FEA4)
  ZSH_HIGHLIGHT_REGEXP+=('[[:<:]]('${(j:|:)${(k)ABBR_GLOBAL_USER_ABBREVIATIONS}}')$' fg=#97FEA4)
else
  ZSH_HIGHLIGHT_REGEXP+=('^[[:blank:][:space:]]*('${(j:|:)${(k)ABBR_REGULAR_USER_ABBREVIATIONS}}')$' fg=#97FEA4)
  ZSH_HIGHLIGHT_REGEXP+=('\<('${(j:|:)${(k)ABBR_GLOBAL_USER_ABBREVIATIONS}}')$' fg=#97FEA4)
fi

# make grep highlight results using color
alias grep='grep --color=auto'

# Add color to less / man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

# Always enable file watchers and hot module reloading.
export PILLAR_DEV_WEB=true
# Always use the top-level src directory as the watch target, to include
# things like the web design system in the watched files (and not just the web clients).
# Note: the trailing slash is important
export PILLAR_HOT_RELOAD_ROOT=src/


echo
echo -e '\t\t\t\tWelcome Ted'
echo

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# set up gvm
[[ -s "/home/ted/.gvm/scripts/gvm" ]] && source "/home/ted/.gvm/scripts/gvm"
