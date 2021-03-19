function lss -d 'Lists contents of directory by size'
    # formatted list sort by size
    ls -lhS $argv[1] | cut -c 28-
end
