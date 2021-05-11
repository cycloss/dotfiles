function showws --description 'cats a file and makes whitespace visible'
    if test (count $argv) -lt 1
        echo 'Please provide an input file'
        return
    end
    cat $argv | gsed 's/\t/<tab>/g' | gsed 's/\s/<space>/g'
end
