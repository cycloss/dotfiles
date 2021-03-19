function tocurly -d 'Converts all square brackets to curly brackets'
    if test (count $argv) -eq 1
        echo $argv | tr '[]' '{}'
    else
        echo "Please provide an input String to convert"
    end
end
