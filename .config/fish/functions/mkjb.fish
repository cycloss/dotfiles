function mkjb -d 'Creates a new Java project base'
    if test (count $argv) -eq 1
        echo "Creating Java Base Project $argv...."
        mkdir $argv
        cd $argv
        cp -r /Users/ted/.config/fish/defaultFiles/Java/standardProject/. .
        code .
    else
        echo "Please provide a name for the Java project"
    end
end
