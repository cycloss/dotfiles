# Defined interactively
function clo --description 'Copy last command output by running it again'
    set -l IFS ''
    # eval evaluates a string as a command
    set -l last (eval (history --max=1))
    echo -n $last | pbcopy
    set -l firstFour (echo -n $last | head -n 3)
    printf 'copying:\n%s\n' $firstFour
    if test (echo $firstFour | wc -l) -gt 2
        echo '.....'
    end
end
