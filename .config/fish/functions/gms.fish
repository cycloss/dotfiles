function gms -d 'git message show, cats out the .gitmessage file'
    cat (git rev-parse --show-toplevel)/.gitmessage
end
