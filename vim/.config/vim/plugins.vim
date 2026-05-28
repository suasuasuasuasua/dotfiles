"builtin
if has('patch-9.1.0375')
  packadd! comment
else
  packadd! vim-commentary
endif
packadd! editorconfig
packadd! helptoc
packadd! hlyank
packadd! nohlsearch

"custom
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
packadd! lightline.vim
packadd! markdown-preview.nvim
packadd! nerdtree
packadd! ultisnips
packadd! vim-devicons
packadd! vim-go
packadd! vim-nix
packadd! vim-snippets
