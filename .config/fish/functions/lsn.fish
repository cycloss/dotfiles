function lsn
    # ls sort by name, case insensitive 
    ls $argv[1] | sort -f
end
