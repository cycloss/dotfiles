function clc -d 'Copies last command to clip board'
    #if arg n provided, will copy the nth last command executed
    #if none will copy last command
    set last $history[1]
    if test -n "$argv[1]"
        if string match -qr '\d+' $argv[1]
            set last $history[$argv[1]]
        else
            echo "arg must be number!"
            return 1
        end
    end
    echo -n $last | pbcopy
    echo "Copied '$last' to clip board..."
end
