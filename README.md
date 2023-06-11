Boon Heng's dotfiles
====================

This is a collection of dotfiles, shell aliases, configuration to set up my personal preferences and commonly used tools in Linux and Mac. 
It can be used to boostrap a linux based machine.

Built both Mac and Ubuntu distribution in mind but should work for debian based linux distribution. Tested with manual configuration, and for use in GitHub Codespaces, and Coder. 

Managed using `chezmoi`, a great dotfiles manager.

### Getting started

Ensure `chezmoi` is installed into the system. Simply tun the following command in the terminal:

```sh
git clone https://github.com/chewbh/dotfiles "$HOME/.dotfiles"
"$HOME/.dotfiles/install.sh"
```

### Terminal Font

This dotfiles uses the ZSH theme [Powerleve10k](https://github.com/romkatv/powerlevel10k), and thus, it requires font with support for the [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) glyphs installed on the host machine.  


### Reference

This dotfiles is heavily influenced and referenced by:

https://github.com/felipecrs/dotfiles

