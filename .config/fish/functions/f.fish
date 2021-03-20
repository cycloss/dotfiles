function f -d "Open directory in Finder"
    if test -z $argv[1]
        open .
    else
        open $argv[1]
    end
end
