function divmod
    if test (count $argv) -eq 2
        set -l ONE $argv[1]
        set -l TWO $argv[2]
        set -l REMAINDER (math $ONE % $TWO)
        set -l GO_IN_COUNT (math -s 0 $ONE / $TWO)
        echo $TWO goes into $ONE $GO_IN_COUNT times with a remainder of $REMAINDER
    else
        echo "Please provide two int args for the calculation"
    end
end