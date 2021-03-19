function cwd -d 'Copies current working directory to clipboard'
    set -l joined (pwd)
    if test -n "$argv[1]"
        set joined $joined"/$argv[1]"
    end
    echo -n $joined | pbcopy
    echo "$joined copied to clipboard..."
end
