# My dotfiles

### File setup

- Install homebrew
- Clone this repo into home
- Delete .git/ in home
- Setup bare repo with:

```shell
mkdir $HOME/.dotfiles && git init --bare $HOME/.dotfiles
```

- Add all dotfiles ect into the bare repo. Example:

```shell
git --git-dir $HOME/.dotfiles/ --work-tree=$HOME add fileName.ext
```

### Program setup

- Rename .brewfile to Brewfile
- Run the following to install brews:
```
brew bundle
```
- Add vscode, karabiner, btt and mos to brew
- Place vscode and karabiner configs where they should be
- Install vscode extensions
- Import btt presets
- mos step 31.01, speed 3.66, duration 2.63, smooth scroll yes


### iTerm2 Setup

- Go to `/System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts` and open it in finder
- Select all the fonts and open, then install to font book. This will allow sf mono to be used in iTerm2

### Keyboard Setup

- Move `CustomLayout.bundle` in .config to /Users/ted/Library/Keyboard\ Layouts and add it from keyboard prefs, input sources, add, *Others*
- This custom layout remaps `alt+u` and `alt+o` to nothing instead of symbols so they can be used for shortcuts
