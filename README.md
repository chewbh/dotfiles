Boon Heng's dotfiles
====================

This is a collection of dotfiles, config and scripts that I have for customizing Linux's OS environment to suit my preference and workflow.

### Pre-req

#### ZSH

Install zsh and setup [prezto](https://github.com/sorin-ionescu/prezto) framework

#### Base16 Theme and Shell

Install chriskempson's [Base16-Shell](https://github.com/chriskempson/base16-shell) into `~/.config` and select base16_tomorrow-night theme

```bash
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# append the following into zshrc or bashrc
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# run this command to enable tomorrow-night theme
base16_tomorrow-night
```

#### Neovim

1. Install neovim in debian based linux

```bash
apt install neovim

# create and symlink vimrc for neovim
mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
echo "let &packpath = &runtimepath" >> ~/.config/nvim/init.vim
echo "source ~/.vimrc" >> ~/.config/nvim/init.vim
```

2. Setup Vundle for plugin management

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
3. Install the plugins via Vundle by runing `:PluginInstall` in nvim

### Reference

https://gist.github.com/MohamedAlaa/2961058

### License

All is freely available under the [MIT License](./LICENSE)
