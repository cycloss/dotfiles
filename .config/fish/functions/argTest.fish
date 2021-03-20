function argTest -d "Tests argparse mechanism"
    # examples: 
    # argTest -s --copy -w hello world
    # fags with optional parameters =? must have the arg attached to them directly:
    # argTest -w'Cat' /  argTest --word'Dog' ect
    set -l options h/help c/copy s/search "w/word=?"
    argparse $options -- $argv

    if set -q _flag_help
        echo "Help flag raised"
        return 0
    end

    if set -q _flag_copy
        echo "Copy flag raised"
        return 0
    end

    if set -q _flag_search
        echo "search flag raised"
    end

    if set -q _flag_word
        echo "Word flag raised"
        # if no arg provided, can set one
        if test -z $_flag_word
            echo "But no arg provided"
        else
            echo "arg passed to word: \"$_flag_word\""
        end
    end

    echo "Args were: \"$argv\""
end
