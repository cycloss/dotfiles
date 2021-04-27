function mdtort -d 'Converts .md to .rtf and copies'
    if test (count $argv) -ne 1
        echo 'Please provide a markdown file to convert'
        return
    end
    # -s is standalone doc, -t is to
    pandoc -s --quiet -t html -V monofont:courier -V mainfont:helvetica -V fontsize:10.5pt $argv | textutil -stdin -format html -convert rtf -stdout | pbcopy
    set_color brgreen
    echo "$argv copied to clipboard as rich text"
end
