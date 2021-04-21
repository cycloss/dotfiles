function ninja --description 'Upload a file or directory to tmp.ninja'
    if test (count $argv) -ne 1
        set_color brred
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
    set -l response (curl -F files[]=@$fileUri 'https://tmp.ninja/upload.php')

    if test (echo $response | jq -r .success) = true
        set uploadUrl (echo $response | jq .files[0].url)
        set_color brgreen
        echo -e "\nUploaded $argv to: $uploadUrl"
        echo "Upload URL copied to clipboard"
        set_color normal
        if test -e $zipName
            echo -e '\nRemoving zipped directory...'
            rm -rf $zipName
        end
        echo -n $uploadUrl | pbcopy
    else
        set_color brred
        set error (echo $response | jq -r .description)
        echo -e "\nError: $error"
    end

end
