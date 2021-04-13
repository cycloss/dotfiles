function lss -d 'Lists contents of directory by size'
    # l is long format
    # h is human readable
    # S is by size
    # r is reversed sort order
    # cut formats list
    ls -lhSr $argv[1] | cut -c 28-
end
