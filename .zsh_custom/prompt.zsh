# My minimal prompt, with a git status loosely based on the fish shell

# if ssh session, show username
sshPromptSegment() {
  if [[ -n $SSH_CLIENT ]]; then
    echo -n '%F{#535623}%n@%m%f '
  fi
}

# checks if the path is at least 4 elements long or more, if true prints the first element, some dots then the last 2 elements otherwise the full path is printed
pathSegment() {
    echo -n '%(4~|%-1~/…/%2~|%~)'
}

isGitRepo() {
    command test -d .git || command  git rev-parse --git-dir >/dev/null 2> /dev/null
}

gitIsDirty() {
    # The first checks for staged changes, the second for unstaged ones.
    # We put them in this order because checking staged changes is *fast*.
    ! command git diff-index --cached --quiet HEAD -- >/dev/null 2>&1 || ! command git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1
}

gitBranchName() {
    command git symbolic-ref --short HEAD 2> /dev/null || command git show-ref --head -s --abbrev | head -n1 2> /dev/null
}

gitStatus() {

    promptMarker="▷"

    if  ! isGitRepo; then
        echo -n "$promptMarker"
        return 0
    fi
    
    echo -n "on %F{#97FEA4}$(gitBranchName)%f "
    
    ahead="↑"
    behind="↓"
    diverged="⥄"
    dirty="⨯"
    uptodate="◦"

    if gitIsDirty; then
        echo -n "$dirty"
        return 0
    fi

    commit_count=$(command git rev-list --count --left-right "@{upstream}...HEAD" 2> /dev/null)
    case "$commit_count" in
        "")
          # no upstream
            echo -n "$promptMarker"
        ;;  
        "0	0")
            echo -n "$uptodate"
        ;;    
        *'	'0)
            echo -n "$behind"
        ;;
        0'	'*)
            echo -n "$behind"
        ;;
        *)
            echo -n "$diverged"
        ;;    
    esac
}

setopt PROMPT_SUBST # must be set to allow expansion

PROMPT='$(sshPromptSegment)%F{#C1EDD4}$(pathSegment)%f $(gitStatus) '

# if last exit code was not zero, show in red
RPROMPT='%(?..%B%F{red}%?%f%b)'