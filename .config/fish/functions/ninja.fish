function ninja --description 'Upload a file or directory to tmp.ninja'
    if test (count $argv) -ne 1
        echo 'Please provide a file to upload'
        return
    end
    if test -d $argv
        echo 'Zipping directory...'
        set zipName (basename $argv)'.zip'
        zip -rj $zipName $argv
        set fileUri (realpath $zipName)
    else
        set fileUri (realpath $argv)
    end
    echo -e 'Uploading...\n'
    set -l res (curl -F file=@$fileUri 'https://tmp.ninja/api.php?d=upload-tool')
    set_color brgreen
    echo -e "\nUploaded $argv to: $res"
    echo "Upload URL copied to clipboard"
    set_color normal
    if test -e $zipName
        echo -e '\nRemoving zipped directory...'
        rm -rf $zipName
    end
    echo -n $res | pbcopy
end
