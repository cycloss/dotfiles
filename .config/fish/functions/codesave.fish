function codesave -d 'Saves vscode extensions to txt file'
    code --list-extensions >'/Users/ted/Library/Application Support/Code/User/extensions.txt'
    echo 'Saved vscode extensions'
end
