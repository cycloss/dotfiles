

# new script. ands are to quit if failed at any point
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

ghsetupUsage() {
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
                ghsetupUsage
                return
                ;;
            p)
                pflag="true"
                ;;
            ?)     
                echo -e "unknown flag $OPTARG\n"
                ghsetupUsage
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
        ghsetupUsage
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