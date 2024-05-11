#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Ensure essential programs are installed
# ------------------------------------------------------------------------------
# Ensure that the following packages are installed for homebrew
# build-essential procps curl file git
MISSING_PROGRAMS=0
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    apt update
    apt install -y build-essential procps curl file git
else [[ "$OSTYPE" == "darwin"* ]]
    xcode-select --install
fi

# ------------------------------------------------------------------------------
# Install plugin managers
# ------------------------------------------------------------------------------
echo 'Installing plugin managers...'

# Install homebrew (macOS and Linux package manager)
echo '  Installing homebrew...'
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
brew install gcc node vim tmux fzf fpp

# Set up fzf key bindings and fuzzy completion
echo '  Adding FZF to the shell...'
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'eval "$(fzf --zsh)"' >> ~/.zshrc
    eval "$(fzf --zsh)"
else
    echo 'eval "$(fzf --bash)"' >> ~/.bashrc
    eval "$(fzf --bash)"
fi

# ------------------------------------------------------------------------------
# Copy all the dotfiles
# ------------------------------------------------------------------------------
# vim, tmux
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
