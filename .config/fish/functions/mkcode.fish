
function mkcode
    if test (count $argv) -ne 1
        echo 'Please provide a single project name'
        return 1
    end
    mkdir $argv[1]
    code $argv[1]
end