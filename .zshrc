
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

unsetopt LIST_BEEP # do not beep on tab complete

autoload -Uz vcs_info
autoload -Uz zcalc # enable calculator

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

# left and right with cmd j and l
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
bindkey "^[[C" forward-char
# history substring search seems to work differently on macos and linux
if [[ $OSTYPE == darwin* ]]; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
else
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
fi

# used for auto suggestions
# must compinit for completion (tabbed) suggestions to work
autoload -Uz compinit && compinit
ZSH_AUTOSUGGEST_STRATEGY=(history)
_comp_options+=(globdots)

# case insensitive tab auto complete (directories) only if there is no case sensitive match
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

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

echo
echo -e '\t\t\t\tWelcome Ted'
echo
