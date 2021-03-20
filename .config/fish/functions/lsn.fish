function lsn -d 'Lists contents of directory sorted by name'
    # ls sort by name, case insensitive 
    ls $argv[1] | sort -f
end
