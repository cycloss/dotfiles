function methget -d 'Lists method sigs in file, -s for add semicolon'
    # -s adds a semicolon at end of functions
    argparse s/semicolon -- $argv

    if test (count $argv) -lt 1
        echo "Please provide a file name to search for method signatures"
        return 1
    end

    set semicolon (set -q _flag_semicolon && echo ';' || echo '')
    # match word optional space any number of times, then open bracket, then anything, then close bracket, then make sure that space open brace is ahead
    # then insert semicolon variable
    ggrep -oP '(\w+\s?)*\(.*\).*(?=\s\{)' $argv | sed "s/\$/$semicolon/"
end
