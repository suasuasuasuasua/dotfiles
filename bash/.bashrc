# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Shell options
shopt -s autocd 2>/dev/null   # cd by typing directory name (bash 4+)
shopt -s histappend           # append to history, don't overwrite
shopt -s checkwinsize         # update LINES/COLUMNS after each command
shopt -s globstar 2>/dev/null # enable ** glob (bash 4+)

# History
HISTFILE="$HOME/.bash_history"
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups

# Colors for ls
if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
else
  export CLICOLOR=1
fi

# Bash completion
for _bc in "/etc/bash_completion" \
  "/usr/share/bash-completion/bash_completion" \
  "/opt/homebrew/etc/profile.d/bash_completion.sh" \
  "/opt/homebrew/etc/bash_completion";
do
  if [ -f "$_bc" ] && ! shopt -oq posix; then
    . "$_bc"
    break
  fi
done
unset _bc

# Git prompt
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
      found=true
      break
    fi
  done
  $found && break
done
unset base found stem

# Virtual env tag for prompt
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename "$VIRTUAL_ENV")) "
  fi
}

# Dynamic prompt with git info (uses PROMPT_COMMAND for GIT_PS1_SHOWCOLORHINTS support)
_set_prompt() {
  if declare -f __git_ps1 >/dev/null 2>&1; then
    __git_ps1 "$(show_virtual_env)\u@\h:\w" " \\\$ "
  else
    PS1="$(show_virtual_env)\u@\h:\w \$ "
  fi
}
PROMPT_COMMAND=_set_prompt

# Aliases and git functions
source "$HOME/.config/bash/alias.bash"
source "$HOME/.config/bash/git.plugin.bash"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# Paths
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

# Other env variables
export EDITOR=nvim

# misc
eval "$(fzf --bash)"
eval "$(direnv hook bash)"
