#!/usr/bin/zsh

###############################################################################
# This Script will install everything required for oh-my-zsh, Powerlevel10k,  #
# Nerd Fonts, and the dotfiles in this repo. It will take a long time to run  #
# as the Nerd Fonts will need to download and they are over 2GB in size.      #
###############################################################################

# Install Terminator
sudo apt install terminator -y

# Install NeoVim and dependants
sudo apt install neovim pyenv exuberant-ctags git ack-grep -y
pyenv install 3.8.0
pyenv local 3.8.0
pip install neovim pep8 flake8 pyflakes pylint isort black

# Download and install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Download PowerLevel10K and put it in the custom theme directory for oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Download Nerd Fonts
wget https://github.com/ryanoasis/nerd-fonts/archive/master.zip
# Extract and install Nerd Fonts
unzip ./master.zip
cd master
./install.sh

# Download plugins for oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Symlink dotfiles. This allows updates to dotfiles to be automatically applied
# just by pulling an update from this repo
[[ ! -d "~/.config/terminator" ]] && mkdir -p ~/.config/terminator
[[ -a "~/.config/terminator/config" ]] && mv ~/.config/terminator/config ~/.config/terminator/config.old
ln -s ./terminator/config ~/.config/terminator/config

[[ -a "~/.zshrc" ]] && mv ~/.zshrc ~/.zshrc.old
ln -s ./zsh/.zshrc ~/.zshrc

[[ -a "~/.p10k.zsh" ]] && mv ~/.p10k.zsh ~/.p10k.zsh.old
ln -s ./zsh/.p10k.zsh ~/.p10k.zsh

[[ ! -d "~/.config/nvim" ]] && mkdir -p ~/.config/nvim
[[ -a "~/.config/nvim/init.vim" ]] && mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.old
ln -s ./neovim/init.vim ~/.config/nvim/init.vim
