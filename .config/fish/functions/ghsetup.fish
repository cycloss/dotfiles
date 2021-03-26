function ghsetup -d 'Sets up a new GitHub repo. (-p | --private)'
    argparse p/private -- $argv

    if test -z "$argv"
        echo 'Please provide a repo name'
        return 1
    end

    set -l visibility (set -q _flag_private && echo 'true' || echo 'false')

    echo -e "Setting up remote repo with settings:{\"name\":\"$argv\",\"private\":$visibility}\n"
    # -s is silent, S is show error even when silenced
    set -l res (curl -sS -u lucas979797:(cat /Users/ted/.k) https://api.github.com/user/repos -d "{\"name\":\"$argv\",\"private\":$visibility}")
    # -j is raw with no new line
    set -l url (echo $res | jq -j .git_url | sed 's/git:\/\//https:\/\//g')
    set_color brgreen
    echo -e "Remote repo "$argv" successfully created!\n"
    set_color normal
    set -l rem_add_cmnd "git remote add origin $url"
    echo -n $rem_add_cmnd | pbcopy
    echo "Remote add command: \"$rem_add_cmnd\" copied to clipboard"
end
