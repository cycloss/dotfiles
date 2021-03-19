function mcd -d 'Creates and cds into a directory'
    if test (count $argv) -lt 1
        echo "Please provide a directory name"
        return
    else
        mkdir $argv[1]
        cd $argv[1]
    end
end
