function pkgstatementadd
    if test (count $argv) -eq 1
        set -l PACKAGENAME $argv[1]
        set -l UPDATE_COUNT 0
        for file in (echo *.java | string split ' ')
            echo $PACKAGENAME\n | cat - $file > temp && mv temp $file
            set UPDATE_COUNT (math $UPDATE_COUNT + 1)
        end
        echo $UPDATE_COUNT file\(s\) updated with package name $PACKAGENAME
    else
        echo "Please enter a java package name"
    end
end