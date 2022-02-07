function gma -d 'git message add, appends message $argv to the .gitmessage file in the current repo'
    echo "- $argv" >>(git rev-parse --show-toplevel)/.gitmessage
    cat (git rev-parse --show-toplevel)/.gitmessage
end
