function cf --description 'Copies file contents to clipboard'
    # grep -c counts occurences of pattern
    set -l textCount (file "$argv"|grep -c 'text')
    if test $textCount -ge 1
        cat "$argv" | pbcopy
        echo "Copied $argv to clipboard"
    else
        echo "File \"$argv\" is not plain text..."
    end
end
