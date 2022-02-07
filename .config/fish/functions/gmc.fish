function gmc -d 'git message commit file, uses .gitmessage file as the message for a new commit'
    if test -z $argv
        read -l -P 'Please enter a primary message for the commit: ' primaryMessage
        echo $primaryMessage
        if not confirmPrompt
            echo 'Aborting...'
            return 1
        end
    else
        set primaryMessage $argv
    end

    set_color yellow
    echo 'You are about to commit:'
    echo 'Primary message:'
    set_color normal
    echo $primaryMessage
    set_color yellow
    echo 'Secondary message:'
    set_color normal
    cat (git rev-parse --show-toplevel)/.gitmessage
    set_color yellow
    echo 'As the primary and secondary commit message'
    set_color normal
    if confirmPrompt
        set -l IFS # set IFS to empty to prevent fish changing lines into a list with no new lines 
        set secondary (cat (git rev-parse --show-toplevel)/.gitmessage)
        git commit -m $primaryMessage -m "$secondary" && gmi
    else
        echo 'Aborting...'
    end
end
