#!/bin/bash

sudo pacman -Sy yay
yay -Sy alacritty neovim python-neovim xclip nerd-fonts-dejavu-complete ttf-dejavu-sans-code zsh lsd
mkdir ~/.config/alacritty
ln -sv /home/dustyp/code/dotfiles/config/alacritty/alacritty_laptop.yml /home/dustyp/.config/alacritty/alacritty.yml
mkdir ~/.config/nvim
ln -sv /home/dustyp/code/dotfiles/config/nvim/init.vim /home/dustyp/.config/nvim/init.vim
mkdir ~/.config/zsh
ln -sv /home/dustyp/code/dotfiles/config/zsh/zshrc ~/.zshrc
ln -sv /home/dustyp/code/dotfiles/config/zsh/aliases.zsh ~/.config/zsh/aliases.zsh
ln -sv /home/dustyp/code/dotfiles/config/zsh/plugins.zsh ~/.config/zsh/plugins.zsh
ln -sv /home/dustyp/code/dotfiles/config/zsh/themes.zsh ~/.config/zsh/themes.zsh
ln -sv /home/dustyp/code/dotfiles/config/zsh/spaceship.zsh ~/.config/zsh/spaceship.zsh
ln -sv /home/dustyp/code/dotfiles/config/zsh/plugins ~/.config/zsh/plugins
cd ~/code/dotfiles/config/zsh/plugins/
git clone git@github.com:zsh-users/zsh-autosuggestions.git
git clone git@github.com:MichaelAquilina/zsh-you-should-use.git
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git
cd ../themes/
ln -sv /home/dustyp/code/dotfiles/config/zsh/themes ~/.config/zsh/themes
git clone git@github.com:spaceship-prompt/spaceship-prompt.git
git config --global user.email "dustin@djpianalto.com"
git config --global user.name "Dustin Pianalto"
chsh -s /bin/zsh
reboot
