

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

fi

# ghsetup() { 'Sets up a new GitHub repo. (-p | --private)'
#     getopts "p"

#     if test -z "$argv"
#         echo 'Please provide a repo name'
#         return 1
#     end

#     set -l visibility (set -q _flag_private && echo 'true' || echo 'false')

#     echo -e "Setting up remote repo with settings:{\"name\":\"$argv\",\"private\":$visibility}\n"
#     # -s is silent, S is show error even when silenced
#     set -l res (curl -sS -u lucas979797:(cat /Users/ted/.k) https://api.github.com/user/repos -d "{\"name\":\"$argv\",\"private\":$visibility}")
#     # -j is raw with no new line
#     set -l url (echo $res | jq -j .git_url | sed 's/git:\/\//https:\/\//g')
#     set_color brgreen
#     echo -e "Remote repo "$argv" successfully created!\n"
#     set_color normal
#     set -l rem_add_cmnd "git remote add origin $url"
#     echo -n $rem_add_cmnd | pbcopy
#     echo "Remote add command: \"$rem_add_cmnd\" copied to clipboard"
# }