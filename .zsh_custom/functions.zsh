

# new script adds a new executable script, immediately opening it in nano
ns() {
    if [[ $# -ne 1 ]]; then
        echo 'ns expects exactly 1 argument'
        return 1
    fi
    script="$@" &&\
    touch $script &&\
    chmod u+x $script &&\
    echo -e '#! /bin/bash\n' >> $script &&\
    nano $script
}

# only available on macos
if [[ $OSTYPE == darwin* ]]; then

    # Copies current working directory to clipboard
    cwd() {
        local joined="$(pwd)"
        # If files are specified as arguments, these will be added to the path
        if test -n "$1"; then
            joined="$joined/$1"
        fi
        echo -n "$joined" | pbcopy
        echo "$joined copied to clipboard..."
    }

    # Creates a new project in vscode
    mkcode() {
        if [[ -z "$1" ]]; then
            echo "mkcode requires at least one argument, the project name"
        fi

        local proj_dir="$1"
        mkdir "$proj_dir"
        # create an array
        files=("$@")
        # iterate through from index 1
        for file in "${files[@]:1}"; do
            echo "$proj_dir/$file"
        done
        code $proj_dir
    }
    
fi

# make a new directory and cd into it
mkcd() {
    # $* is all positional arguments as single string when quoted
    mkdir "$*"
    cd "$*"
}

myip() {
    echo -n 'lan: '
    # exclude loopback and docker
    ip -4 a | grep "inet " | grep -vE '(127.0.0.1|172.17.0.1)' | awk '{print $2}'
    echo -n 'wan: '
    curl -s icanhazip.com || echo 'N/A'
}

ghsetupusage() {
cat << EOF
ghsetup [ -hp ] [ REPO_NAME ]

Set up a new Github repo, where:
    -h          show this help
    -p          set up private repo (defaults to public)
    REPO_NAME   the name of the new repo e.g. test-repo
EOF
}

ghsetup() {
    # declare local to avoid setting in global scope (will carry over)
    local pflag

    while getopts ":hp" flag; do
        case "$flag" in
            h)
                ghsetupusage
                return
                ;;
            p)
                pflag="true"
                ;;
            ?)     
                echo -e "unknown flag $OPTARG\n"
                ghsetupusage
                return
                ;;
        esac
    done

    if [[ -z "$pflag" ]]; then
        pflag="false"
    fi  

    shift $(($OPTIND - 1)) # removes processed parameters by shifting first arg pointer forward

    # check that only one non flag arg provided
    if [[ $# -ne 1 ]]; then
        echo -e "error: a single repo name is expected\n"
        ghsetupusage
        return
    fi

    repoName="$*"

    echo "Setting up remote repo with settings: name: $repoName, private: $pflag"
    
    # -s is silent, S is show error even when silenced
    local res="$(curl -sS -u cycloss:$(cat ~/.k) https://api.github.com/user/repos -d "{\"name\":\"$repoName\",\"private\":$pflag}")"
#     # -j is raw with no new line
    local url="$(echo $res | jq -j .git_url)"

    echo -e "$fg[green]Remote repo "$repoName" successfully created!$reset_color"
    local rem_add_cmd="git remote add origin $url"
    echo -n "$rem_add_cmd" | pbcopy
    echo "Remote add command: \"$rem_add_cmd\" copied to clipboard"
}

# gac (git add changed) takes a commit hash and adds all files that were changed in that commit hash and have changes in the working directory to the staging area.
# This is useful for fixing up for a rebase if you have a load of changes and you need to sort through commits to find out which changes need to go with which commit.
gac() {
    gitroot
    validatecommithash "$1"
    print -P "%F{green}git adding files changed in commit $1 that have changes in the working directory:%f"
    # -r makes it go into all dirs of repo rather than just top level
    files=$(git diff-tree --no-commit-id --name-only -r "$1")
    # -r prevents backslashes from being interpreted as escape characters
    added=false
    while read -r file; do
        if [[ -e "$file" ]]; then
            if [[ -n $(git status --porcelain "$file") ]]; then 
                added=true
                echo "    $file"
                git add "$file"
            fi 
        fi
    done <<< "$files"
    echo

    if [[ $added == "false" ]]; then
        print -P "%F{yellow}no files of commit $1 were changed in the working directory so nothing added%f"
        echo
        return 3
    fi
}

# gacf (git add changed fixup) is gac but with an immediate fixup commit for the given hash 
gacf() {
    gac "$1"
    stat=$?

    if [ $stat -eq 3 ]; then
        print -P "%F{yellow}skipping commit $1 as nothing to fix up%f"
        echo
        return 0
    elif [ $stat -ne 0 ]; then
        return $stat
    fi
    
    print -P "%F{green}fixing up commit $1%f"
    git commit --fixup "$1"
    echo
}

# gacfs (git add changed fixup since) is gacf for every single commit since the given commit (does not include that given commit)
# It applies fixups in the order of oldest commit to newest. It does not automatically rebase.
gacfs() {
    validatecommithash $1
    echo "processing commits from $1..HEAD (exclusive of $1)" >&2
    echo
    commits=$(git log "$1"..HEAD --pretty=format:%H --reverse)
    while read -r commit; do
        gacf "$commit"
    done <<< "$commits"
}

validatecommithash() {
    commit_hash=$1
    git show "$commit_hash" > /dev/null
    if [[ $? -ne 0 ]]; then
        print -P "%F{red}Invalid commit hash '$commit_hash'%f"
        return 1
    fi
}

gitroot() {
    if [[ "$(git rev-parse --show-toplevel)" != "$(pwd)" ]]; then
        cd $(git rev-parse --show-toplevel)
    fi
}

# gitresolveallours resolves conflicts in favour of ours during a merge conflict when files are still uncommitted
gro() {
    git diff --name-only --diff-filter=U | xargs git checkout --ours
}

# gitresolvealltheirs resolves conflicts in favour of theirs during a merge conflict when files are still uncommitted
grt() {
    git diff --name-only --diff-filter=U | xargs git checkout --theirs
}

# grls (git reflog search) searches all commits in the reflog for a given string, and outputs which commits it is found in
grls() {
    git reflog | awk '{print $1}' | xargs -I{} sh -c \
    'git diff-tree --no-commit-id --name-only -r {} | while read filename; do \
        git show {}:"$filename" 2>/dev/null | grep -q "$1" && echo "[found in commit {}]: $filename"; \
     done' -- "$1"
}

# gitchangedfilediffs uses the first argument's commit hash to get a list of files changed since that hash, then gets the difference in those files between the HEAD and the second argument's commit hash
gitchangedfilediffs() {

    # Get the list of changed files from the first commit
    local changed_files=$(git diff --name-only "$1")

    # Iterate over each changed file and show the diff
    while read -r file; do
        git diff "$2" "HEAD" -- "$file"
        echo "\n\n\n\n\n\n\n"
    done <<< "$changed_files"
}

# set the path of this file as a variable on load of this script
func_file_path="$(readlink -f "$0")"

# lf (list functions) lists all the functions in this file (functions.zsh)
lf() {
  # Read the file line by line
  while IFS= read -r line; do
    # Check if the line starts with "function_name() {"
    if [[ $line =~ '^([\w_]+)\(\)\s\{' ]]; then
      # Extract the function name
      function_name="$match[1]"
      echo $function_name
    fi
  done < "$func_file_path"
}

confirm() {
    echo "Are you sure you want to $1? (y/n): "
    read answer
    if [[ "$answer" != "y" ]]; then
        print -P "%F{yellow}Operation Aborted%f"
        return 1
    fi
}

grho() {
    origin="origin/$(git branch --show-current )"
    confirm "hard reset HEAD to $origin"
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    git reset --hard "$origin"
}

# execdirs runs the given string command in all directories
execdirs() {
    local command=("$@")

    # Iterate through each directory in the current directory
    for dir in */; do
        if [ -d "$dir" ]; then
            print -P "%F{green}Running command '${command[*]}' in directory: $dir%f"
            (cd "$dir" && "${command[@]}")
        fi
    done
}

# potp (pillar one time password) gets the one time password from the pillar local environment secret and copies it to the clipboard
potp() {
    TOTP=$(pillar login totp "ZMNTNU4IXXHKK2YPP3ATHBUPSCZCQJR2" 2>&1)
    # This removes TOPT: prefix from the output
    echo -n ${TOTP#"TOTP: "} | xclip -selection clipboard
}

# pnuke (pillar nuke) nukes the pillar local environment
pnuke() {
    make pillar
    pillar destroy
    git clean -xdf -e src/clients/ -e .vscode/ -e src/services -e src/pkg -e src/cmd -e src/gateways -e src/tools -e src/test
    # mkdir logs
    # rm -rf /usr/local/share/terraform/providers/gitlab.com/adalpha/custom-cert
    # make tf-provider-clean
    make tf-provider
}
