"builtin
if has('patch-9.1.0375')
  packadd! comment
else
  packadd! vim-commentary
endif
if has('patch-9.0.1799') | packadd! editorconfig | endif
silent! packadd! helptoc
silent! packadd! hlyank
silent! packadd! nohlsearch
if has('patch-8.1.0360') | packadd! termdebug | endif

"pack/plugin/opt/
packadd! auto-pairs
packadd! direnv.vim
packadd! fzf
packadd! fzf.vim
packadd! lightline.vim
packadd! markdown-preview.nvim
packadd! nerdtree
packadd! rainbow_parentheses.vim
packadd! targets.vim
packadd! ultisnips
packadd! undotree
packadd! vim-devicons
packadd! vim-dispatch
packadd! vim-fugitive
packadd! vim-gitgutter
packadd! vim-go
packadd! vim-indent-guides
packadd! vim-nix
packadd! vim-repeat
packadd! vim-sensible
packadd! vim-sleuth
packadd! vim-snippets
packadd! vim-surround
packadd! vim-tmux-navigator
packadd! vim-trailing-whitespace
packadd! vim-unimpaired
packadd! vim-vinegar
packadd! vim-which-key
packadd! vimspector

let s:node_version = system('node --version 2>/dev/null')
"coc.nvim requires nodejs >=20.19.0
if str2nr(matchstr(s:node_version, '\v\d+')) * 1000 + str2nr(matchstr(s:node_version, '\v\.\zs\d+')) >= 20019
  packadd! coc.nvim
  let s:coc_path = expand('<sfile>:p:h') . '/pack/plugin/opt/coc.nvim'
  "install the coc.nvim package
  if !filereadable(s:coc_path . '/build/index.js')
    call system('cd ' . shellescape(s:coc_path) . ' && npm ci')
  endif
endif
