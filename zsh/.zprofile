# Homebrew
if whence /usr/bin/brew >/dev/null; then
  eval "$(/usr/bin/brew shellenv zsh)"
fi

# PATH
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
if ! [[ "$PATH" =~ "$HOME/.cargo/bin" ]]; then
  PATH="$HOME/.cargo/bin:$PATH"
fi
if ! [[ "$PATH" =~ "$HOME/go/bin" ]]; then
  PATH="$HOME/go/bin:$PATH"
fi
export PATH

# Environment
export EDITOR=nvim
