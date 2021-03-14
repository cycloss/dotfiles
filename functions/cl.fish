#if arg n provided, will copy the nth last command executed
#if none will copy last command
function cl
    if test -n "$argv[1]"
        if string match -qr '\d+' $argv[1]
            set last (history | sed -n "$argv[1]p")
        else
            echo "arg must be number!"
            return 1
        end
    else
        set last (history | head -n1)
    end
    echo $last | pbcopy
    echo "Copied '$last' to clip board..."
end
