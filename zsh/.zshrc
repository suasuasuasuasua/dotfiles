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

# PS1
setopt prompt_subst

source "$HOME/.config/zsh/git-prompt.sh"
GIT_PS1_SHOWCOLORHINTS="yes" # adds colors to prompt
GIT_PS1_SHOWCONFLICTSTATE="yes" # |CONFLICT indicates merge conflicts
GIT_PS1_SHOWDIRTYSTATE="true" # * indicates dirty
GIT_PS1_SHOWUNTRACKEDFILES="true" # % indicates untracked
GIT_PS1_SHOWUPSTREAM="verbose" # <, >, <>, = for upstream state

PS1='%n@%m:%/$ '
RPROMPT=$'$(__git_ps1 "%s")'

# completion
fpath=("$HOME/.config/zsh" $fpath)

# alias
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/git.plugin.zsh"

# paths
export PATH="$HOME/.cargo/bin":$PATH

# other
source <(fzf --zsh)
eval "$(direnv hook zsh)"
