function gia -d 'Adds $argv to .gitignore of current git repo'
    # add new line to prevent going onto same line?
    # echo ''
    for arg in $argv
        echo $arg >>(git rev-parse --show-toplevel)/.gitignore
    end
    # echo $argv >>(git rev-parse --show-toplevel)/.gitignore
end
