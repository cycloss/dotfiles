function lsn -d 'Lists contents of directory by name'
    # ls sort by name, case insensitive 
    ls $argv[1] | sort -f
end
