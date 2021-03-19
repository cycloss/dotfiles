function getkey -d 'Gets apple script keycodes'
    if test (count $argv) -ne 1
        echo "Please provide a search term"
        return
    end
    grep $argv[1] /Users/ted/.config/fish/defaultFiles/applescript/keycodes.txt
end
