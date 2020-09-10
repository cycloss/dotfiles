function mkjavabase
    if test (count $argv) -eq 1
        echo "Creating Java Base Project $argv...."
        mkdir $argv
        cd $argv
        cp /Users/ted/.config/fish/defaultFiles/Java/Main.java .
        cp /Users/ted/.config/fish/defaultFiles/Java/MainTest.java .
        cp -r /Users/ted/.config/fish/defaultFiles/Java/.vscode .
        code .
    else
        echo "Please provide a name for the project"
    end
end