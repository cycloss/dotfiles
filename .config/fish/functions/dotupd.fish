# Defined in /var/folders/l6/4wtwvg1903l93zlk1_5rzrzr0000gn/T//fish.aQ9tnO/dotupd.fish @ line 2
function dotupd --description 'Loads new files and adds all changes to dotfile repo'
    code --list-extensions >"$HOME/.code/extensions.txt"
    cp "$HOME/Library/Application Support/Code/User/settings.json" "$HOME/.code"
    cp "$HOME/Library/Application Support/Code/User/keybindings.json" "$HOME/.code"
    echo 'Saved vscode files...'
    brew bundle dump -f --file=$HOME/.brewfile
    echo 'Saved brewfile...'
    git --git-dir $HOME/Dotfiles/ --work-tree=$HOME add -A $HOME/.config/fish
    echo 'Saved new fish files...'
    git --git-dir $HOME/Dotfiles/ --work-tree=$HOME add -u
    echo 'Updated dotfile repo...'
    git --git-dir $HOME/Dotfiles/ --work-tree=$HOME status
end
