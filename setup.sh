#!/usr/bin/env bash

# Ensure that the following programs are installed in one if-else block
# git, curl, vim, tmux
if ! command -v git &> /dev/null; then
    echo 'git is not installed. Please install git and try again.'
    echo '  Linux: apt install git'
    echo '  MacOS: xcode-select --install'
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo 'curl is not installed. Please install curl and try again.'
    echo '  Linux: apt install curl'
    echo '  MacOS: xcode-select --install'
    exit 1
fi

# ------------------------------------------------------------------------------
# Install plugin managers
# ------------------------------------------------------------------------------
echo 'Installing plugin managers...'

# Install homebrew (macOS and Linux package manager)
echo '  Installing homebrew...'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "  Adding homebrew binary path to PATH..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo '  MacOS detected...'
    # Add homebrew binary path to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' > ~/.zprofile

    # Install Oh My Zsh
    echo '  Installing Oh My Zsh...'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
    echo '  Linux detected...'
    # Add homebrew binary path to PATH
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' > ~/.bashrc

    # Install Oh My Bash
    echo '  Installing Oh My Bash...'
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
fi

# Install default pacakges using homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install node vim tmux gcc node

# Install vim-plug (vim plugin manager)
echo '  Installing vim-plug...'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install the vim plugins
echo '      Installing vim plugins'
vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"

# Install tpm (tmux plugin manager)
echo '  Installing tpm...'
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Install the tmux plugins
echo '      Installing tmux plugins...'
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# ------------------------------------------------------------------------------
# Copy all the dotfiles
# ------------------------------------------------------------------------------
# Find all the dotfiles but strip the leading ./ from the path
dotfiles=$(find . -name ".*" -type f | sed 's|^\./||')

# Copy each dotfile to the home directory
echo 'Copying dotfiles...'
for dotfile in $dotfiles; do
    echo "  $dotfile -> ~/$dotfile"
    cp $dotfile ~
done

