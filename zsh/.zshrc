# run setup command again with
#
# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/justinhoang/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PS1='%n@%m:%/$ '

# plugins
source "$HOME/.config/zsh/git.plugin.zsh"

# alias
source "$HOME/.config/zsh/alias.zsh"

# paths
export PATH="$HOME/.cargo/bin":$PATH

# other
source <(fzf --zsh)
eval "$(direnv hook zsh)"
