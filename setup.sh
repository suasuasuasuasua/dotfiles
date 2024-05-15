#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Ensure essential programs are installed
# ------------------------------------------------------------------------------
# Ensure that the following packages are installed for homebrew
# build-essential procps curl file git
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update
    sudo apt install -y build-essential procps curl file git zsh
    command -v zsh | sudo tee -a /etc/shells
    sudo chsh -s "$(command -v zsh)" "${USER}"
else [[ "$OSTYPE" == "darwin"* ]]
    xcode-select --install
fi

# ------------------------------------------------------------------------------
# Install plugin managers
# ------------------------------------------------------------------------------
echo 'Installing plugin managers...'

# Install Oh My Zsh
echo '  Installing Oh My Zsh...'
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# zsh vi-mode
ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM=$ZSH/custom
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

# Install homebrew (macOS and Linux package manager)
echo '  Installing homebrew...'
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "  Adding homebrew binary path to PATH..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo '  macOS detected...'
    # Add homebrew binary path to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

else
    echo '  linux detected...'
    # Add homebrew binary path to PATH
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Install default pacakges using homebrew
brew install gcc node vim tmux fzf fpp

# ------------------------------------------------------------------------------
# Copy all the dotfiles
# ------------------------------------------------------------------------------
# vim, tmux, zsh, etc.
# Find all the dotfiles but strip the leading ./ from the path
dotfiles=$(find . -name ".*" -type f | sed 's|^\./||')

# Copy each dotfile to the home directory
echo 'Copying dotfiles...'
for dotfile in $dotfiles; do
    echo "  $dotfile -> ~/$dotfile"
    cp $dotfile ~
done

# Install vim-plug (vim plugin manager)
echo '  Installing vim-plug...'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install the vim plugins
echo '      Installing vim plugins'
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"

# Install tpm (tmux plugin manager)
echo '  Installing tpm...'
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Install the tmux plugins
echo '      Installing tmux plugins...'
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# ------------------------------------------------------------------------------
# Set up dotfile configurations
# ------------------------------------------------------------------------------
# Set up mac and linux specific configurations
echo '  Setting up configurations...'
#
# Set up fzf key bindings and fuzzy completion
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo '    Adding config for macOS...'
else
    echo '    Adding config for linux...'
    
    # xclip for pbcopy-like copying
    brew install xclip
    echo 'alias pbcopy="xclip -selection clipboard"' >> ~/.zshrc
    echo 'alias pbpaste="xclip -selection clipboard -o"' >> ~/.zshrc
fi

echo "Finished! Log out and log back in!"
