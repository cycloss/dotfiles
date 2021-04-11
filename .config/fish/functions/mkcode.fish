
function mkcode -d 'Creates a new project in vscode'
    if test (count $argv) -lt 1
        echo 'Please provide a single project name'
        return 1
    end
    set projName $argv[1]
    mkdir $projName
    # If more than one arg, will create files for args after first
    for fileName in $argv[2..]
        set file "$projName/$fileName"
        touch $file
        set -a files $file
    end
    code $projName $files
end
