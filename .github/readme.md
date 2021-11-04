# My dotfiles

### File setup

Within the home directory, to create a bare repo in `.dotfiles/` (doesn't need to exist) run:

```shell
git clone --bare https://github.com/cycloss/dotfiles.git ~/.dotfiles
```

Then to place all dotfiles in home run:

```shell
git --git-dir ~/.dotfiles/ --work-tree=$HOME checkout
```

## Linux

Make sure it has executable permissions and run the install script as root `sudo ~/.config/linuxInstallScript`. This will install `fish`, and `lf`.

### Macos

Install brew with:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Rename .brewfile to Brewfile
- Run the following to install brews:

```shell
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
