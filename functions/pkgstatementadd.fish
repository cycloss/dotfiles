function pkgstatementadd
    if test (count $argv) -lt 2
        echo "Please enter a java package name and file name"
        return 1
    end

    set -l PACKAGENAME $argv[1]
    set -l FILE_NAME $argv[2]
    set -l UPDATE_COUNT 0

    gsed -i "1i $PACKAGENAME\n" $FILE_NAME

    echo "Package name: $PACKAGENAME successfully added to $FILE_NAME"

end