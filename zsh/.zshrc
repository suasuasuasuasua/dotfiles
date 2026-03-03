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
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

# Suggestion from Ubuntu 24.04 (/etc/zsh/)
autoload -Uz promptinit
promptinit
prompt redhat # prompt -l

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# End of lines added by compinstall

# show git hints
# check paths in order
if [[ -e "/usr/share/doc/git/contrib/completion/git-prompt.sh" ]]; then
  source "/usr/share/doc/git/contrib/completion/git-prompt.sh"
elif [[ -e "/usr/share/git-core/contrib/completion/git-prompt.sh" ]]; then
  source "/usr/share/git-core/contrib/completion/git-prompt.sh"
elif [[ -e "/usr/lib/git-core/git-sh-prompt" ]]; then
  source "/usr/lib/git-core/git-sh-prompt"
elif [[ -e "$HOME/.config/zsh/git-prompt.sh" ]]; then
  source "$HOME/.config/zsh/git-prompt.sh"
fi

setopt prompt_subst
GIT_PS1_SHOWCOLORHINTS="yes" # adds colors to prompt
GIT_PS1_SHOWCONFLICTSTATE="yes" # |CONFLICT indicates merge conflicts
GIT_PS1_SHOWDIRTYSTATE="true" # * indicates dirty
GIT_PS1_SHOWUNTRACKEDFILES="true" # % indicates untracked
GIT_PS1_SHOWUPSTREAM="verbose" # <, >, <>, = for upstream state
RPROMPT=$'$(__git_ps1 "%s")'

# alias
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/git.plugin.zsh"

# paths
export PATH="$HOME/.cargo/bin":$PATH
export PATH="$HOME/go/bin":$PATH

# other
source <(fzf --zsh)
eval "$(direnv hook zsh)"
