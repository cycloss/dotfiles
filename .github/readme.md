# Cycloss's Dotfiles

These dotfiles are mainly for zsh, but contain other small configs for nano etc. `~/.zshrc` is where the main config is, and it sources files stored in the `~/.zsh_custom` directory for organisation.

## Repo setup

- Install zsh if not already installed

- Clone the repo (depth 1 for if you don't care about the history):

```shell
git clone --depth=1 --bare https://github.com/cycloss/dotfiles.git ~/.dotfiles
```

- Place all the repo files into home:

```shell
git --git-dir ~/.dotfiles/ --work-tree=$HOME checkout
```
