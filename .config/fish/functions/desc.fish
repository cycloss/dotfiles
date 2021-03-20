function desc -d 'Show description for function'
    set -l d (functions -Dv $argv)
    # 5 is the line where the description from functions output is
    echo "> $d[5]"
end
