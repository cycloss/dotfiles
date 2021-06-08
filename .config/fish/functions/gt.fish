function gt -d "Go to the top level of a git repo"
    cd (git rev-parse --show-toplevel) $argv
end
