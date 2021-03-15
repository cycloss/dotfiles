function lss
    # formatted list sort by size
    ls -lhS $argv[1] | cut -c 28-
end
