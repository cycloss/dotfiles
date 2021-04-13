function lst -d 'Lists contents of directory by date modified'
    # l is long format
    # h is human readable
    # t is by time
    # r is reversed sort order
    # cut formats list
    ls -lhtr $argv[1] | cut -c 28-
end
