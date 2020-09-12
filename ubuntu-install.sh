#!/usr/bin/zsh

###############################################################################
# This Script will install everything required for oh-my-zsh, Powerlevel10k,  #
# Nerd Fonts, and the dotfiles in this repo. It will take a long time to run  #
# as the Nerd Fonts will need to download and they are over 2GB in size.      #
###############################################################################

sudo apt update

# Install Terminator
sudo apt install terminator -y

sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev git

[[ ! -d "$HOME/.pyenv" ]] && curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | /usr/bin/zsh

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Install NeoVim and dependants
sudo apt install neovim exuberant-ctags git ack-grep -y
pyenv install 3.8.0
pyenv local 3.8.0
pip install neovim pep8 flake8 pyflakes pylint isort black

# Download and install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | /usr/bin/zsh
source $HOME/.zshrc
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
[[ ! -d "$HOME/.config/terminator" ]] && mkdir -p ~/.config/terminator
[[ -a "$HOME/.config/terminator/config" ]] && mv ~/.config/terminator/config ~/.config/terminator/config.old
ln -s ./terminator/config ~/.config/terminator/config

[[ -a "$HOME/.zshrc" ]] && mv ~/.zshrc ~/.zshrc.old
ln -s ./zsh/.zshrc ~/.zshrc

[[ -a "$HOME/.p10k.zsh" ]] && mv ~/.p10k.zsh ~/.p10k.zsh.old
ln -s ./zsh/.p10k.zsh ~/.p10k.zsh

[[ ! -d "$HOME/.config/nvim" ]] && mkdir -p ~/.config/nvim
[[ -a "$HOME/.config/nvim/init.vim" ]] && mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.old
ln -s ./neovim/init.vim ~/.config/nvim/init.vim
