function gmi -d 'git message init, adds or renews a .gitmessage file to current repo with comment argv'
    echo -n $argv >(git rev-parse --show-toplevel)/.gitmessage
end
