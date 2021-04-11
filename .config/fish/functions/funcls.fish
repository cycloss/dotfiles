function funcls --description 'Lists all user defined fish functions'
    set -l funcs (ls $HOME/.config/fish/functions | ggrep -oP '.*(?=.fish)')
    for fun in $funcs
        printf '%-15s' $fun
        set -l description (desc $fun)
        if test $description != '> n/a'
            echo $description
        else
            echo
        end
    end
end
