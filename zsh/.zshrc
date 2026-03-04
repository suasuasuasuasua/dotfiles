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

# Define the list of paths to search for git-prompt.sh
setopt prompt_subst
for base in "/usr/share/doc/git/contrib/completion" \
  "/usr/share/git-core/contrib/completion" \
  "/usr/lib/git-core";
do
  found=false

  for stem in "git-prompt.sh" "git-sh-prompt"
  do
    if [ -e "$base/$stem" ]; then
      source "$base/$stem"

      GIT_PS1_SHOWCOLORHINTS="yes" # adds colors to prompt
      GIT_PS1_SHOWCONFLICTSTATE="yes" # |CONFLICT indicates merge conflicts
      GIT_PS1_SHOWDIRTYSTATE="true" # * indicates dirty
      GIT_PS1_SHOWUNTRACKEDFILES="true" # % indicates untracked
      GIT_PS1_SHOWUPSTREAM="verbose" # <, >, <>, = for upstream state
      RPROMPT=$'$(__git_ps1 "%s")'

      found=true
      break
    fi
  done

  if $found then break fi
done

# add venv PS1 tag
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1

# alias
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/git.plugin.zsh"

# paths
export PATH="$HOME/.cargo/bin":$PATH
export PATH="$HOME/go/bin":$PATH

# other
source <(fzf --zsh)
eval "$(direnv hook zsh)"
