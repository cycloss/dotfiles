# Cycloss's Dotfiles

These dotfiles are mainly for zsh, but contain other small configs for nano etc. `~/.zshrc` is where the main config is, and it sources files stored in the `~/.zsh_custom` directory for organisation.

The idea for these dotfiles is for them to be minimal (no plugin manager) but user friendly like the fish shell (which I used to use), and easy to manage by using a bare repo. Plugins are automatically installed by the `~/.zsh_custom/INSTALL` script (see below), and include:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

- [zsh-abbr](https://github.com/olets/zsh-abbr/issues)

Colors for the prompt and syntax highlighting are configured as hex codes and therefore won't show up properly unless your terminal emulator supports true colors. `echo $COLORTERM` will output `truecolor` if it does.

## Install

- Install zsh if not already installed

- Clone the repo (depth 1 for if you want it to be minimal and don't care about the history):

```shell
git clone --depth=1 --bare https://github.com/cycloss/dotfiles.git ~/.dotfiles
```

- Place all the repo files into home (append the `-f` flag if it reports that files are already present):

```shell
git --git-dir ~/.dotfiles/ --work-tree=$HOME checkout
```

- Run the install script which will clone the plugin repos used by this config to where the `.zshrc` expects them to be:

```shell
~/.zsh_custom/INSTALL
```

- `chsh -s $(which zsh)` to change login shell. Will have to log out for it to take effect

## Updating a Shallow Clone on a Server

- `dot pull` which should expand to:

```shell
git --git-dir ~/.dotfiles/ --work-tree=$HOME pull`
```

- `dot checkout` to put the new files where they should be. Should expand to:

```shell
git --git-dir ~/.dotfiles/ --work-tree=$HOME checkout
```

- Then run `rl` (`exec zsh`) to load the new config

- May have to run the install script again to clone the plugin repos used by this config to where the `.zshrc` expects them to be:

```shell
~/.zsh_custom/INSTALL
```

## Updating the Repo

Use the following abbreviations to make working with the bare repo easier:

- `dotu` to update already tracked files

- `dota <file/dir>` to add a file/dir to tracking

- `dotrm <file/dir>` to remove a file/dir from tracking

- `dots` to check the status of the repo

- `dotc` to commit changes

- `dot push` to push changes
