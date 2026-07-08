"default
packadd! auto-pairs
if executable('fzf') | packadd! fzf | packadd! fzf.vim | endif
if executable('ctags') | packadd! vim-gutentags | endif
packadd! targets.vim
packadd! vim-devicons
packadd! vim-dispatch
packadd! vim-fugitive
packadd! vim-gitgutter
packadd! vim-indent-guides
packadd! vim-orgmode
packadd! vim-repeat
packadd! vim-sensible
packadd! vim-sleuth
packadd! vim-speeddating
packadd! vim-surround
packadd! vim-tmux-navigator
packadd! vim-trailing-whitespace
packadd! vim-unimpaired
packadd! vim-vinegar
packadd! vim-which-key

try | packadd! comment | catch | silent! packadd! vim-commentary | endtry

"languages
"packadd! vim-go
"packadd! vim-nix
