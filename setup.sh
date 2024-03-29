#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Ensure essential programs are installed
# ------------------------------------------------------------------------------
# Ensure that the following packages are installed for homebrew
# build-essential procps curl file git
MISSING_PROGRAMS=0
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Check if these packages are installed on apt
    if ! dpkg -s build-essential &> /dev/null; then
        echo 'Please install build-essential and try again.'
        echo '  apt install build-essential'
        MISSING_PROGRAMS=1
    fi
    if ! dpkg -s procps &> /dev/null; then
        echo 'Please install procps and try again.'
        echo '  apt install procps'
        MISSING_PROGRAMS=1
    fi
    if ! dpkg -s file &> /dev/null; then
        echo 'Please install file and try again.'
        echo '  apt install file'
        MISSING_PROGRAMS=1
    fi
fi

if ! command -v git &> /dev/null; then
    echo 'git is not installed. Please install git and try again.'
    echo '  linux: apt install git'
    echo '  macOS: xcode-select --install'
    MISSING_PROGRAMS=1
fi

if ! command -v curl &> /dev/null; then
    echo 'curl is not installed. Please install curl and try again.'
    echo '  linux: apt install curl'
    echo '  macOS: xcode-select --install'
    MISSING_PROGRAMS=1
fi

# Exit if any of the programs are missing
if [ $MISSING_PROGRAMS -eq 1 ]; then
    exit 1
fi

# ------------------------------------------------------------------------------
# Install plugin managers
# ------------------------------------------------------------------------------
echo 'Installing plugin managers...'

# Install homebrew (macOS and Linux package manager)
echo '  Installing homebrew...'
NONINTERACTIVE=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "  Adding homebrew binary path to PATH..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo '  macOS detected...'
    # Install Oh My Zsh
    echo '  Installing Oh My Zsh...'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

    # Add homebrew binary path to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

else
    echo '  linux detected...'
    # Install Oh My Bash
    echo '  Installing Oh My Bash...'
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
    #
    # Add homebrew binary path to PATH
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Install default pacakges using homebrew
brew install gcc node vim tmux

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

