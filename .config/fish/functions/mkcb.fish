function mkcb -d 'Creates a new C project base'
    if test (count $argv) -eq 1
        echo "Creating C Base Project $argv...."
        mkdir $argv
        cd $argv
        cp -r /Users/ted/.config/fish/defaultFiles/C/cProject/. .
        code .
    else
        echo "Please provide a name for the C project"
    end
end
