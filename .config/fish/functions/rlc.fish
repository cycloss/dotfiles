function rlc -d 'Runs the last command'
    # to use output of last command in string:
    # set res (rlc) && echo "hello $res"
    eval $history[1]
end
