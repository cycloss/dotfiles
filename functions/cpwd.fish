function cpwd
    set -l joined (pwd)
    if test -n "$argv[1]"
        set joined $joined"/$argv[1]"
    end
    echo $joined | pbcopy
end
