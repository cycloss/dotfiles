# Defined in /var/folders/l6/4wtwvg1903l93zlk1_5rzrzr0000gn/T//fish.SaR0NS/dotupd.fish @ line 1
function dotupd --description 'Loads new files and adds all changes to dotfile repo'
    code --list-extensions >'/Users/ted/Library/Application Support/Code/User/extensions.txt'
    echo 'Saved vscode extensions...'
    brew bundle dump -f --file=/Users/ted/.brewfile
    echo 'Saved brewfile...'
    git --git-dir /Users/ted/Dotfiles/ --work-tree=/Users/ted add /Users/ted/.config/fish
    echo 'Saved new fish files...'
    git --git-dir /Users/ted/Dotfiles/ --work-tree=/Users/ted add -u
    echo 'Updated dotfile repo...'
    git --git-dir /Users/ted/Dotfiles/ --work-tree=/Users/ted status
end
