# History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd nomatch hist_ignore_all_dups hist_find_no_dups
unsetopt beep
bindkey -e

# Completion
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls='ls --color'
else
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi

# Prompt
autoload -Uz promptinit
promptinit
prompt redhat

setopt prompt_subst
for base in "/usr/share/doc/git/contrib/completion" \
  "/usr/share/git-core/contrib/completion" \
  "/usr/lib/git-core" \
  "/Library/Developer/CommandLineTools/usr/share/git-core" \
  "/System/Volumes/Data/Library/Developer/CommandLineTools/usr/share/git-core";
do
  found=false
  for stem in "git-prompt.sh" "git-sh-prompt"; do
    if [ -e "$base/$stem" ]; then
      source "$base/$stem"
      GIT_PS1_SHOWCOLORHINTS="yes"
      GIT_PS1_SHOWCONFLICTSTATE="yes"
      GIT_PS1_SHOWDIRTYSTATE="true"
      GIT_PS1_SHOWUNTRACKEDFILES="true"
      GIT_PS1_SHOWUPSTREAM="verbose"
      RPROMPT=$'$(__git_ps1 "%s")'
      found=true
      break
    fi
  done
  if $found then break fi
done
unset base found stem

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'" $PS1"

# Plugins
if whence direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

if whence fzf >/dev/null; then
  source <(fzf --zsh)
fi

for base in "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
do
  if [ -e "$base" ]; then
    source "$base"
    break
  fi
done
unset base

# Aliases
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/git.plugin.zsh"
