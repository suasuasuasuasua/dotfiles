if has('patch-9.1.0375') | packadd! comment | else | silent! packadd! vim-commentary | endif
if has('patch-9.0.1799') | packadd! editorconfig | endif
silent! packadd! cfilter
silent! packadd! helptoc
silent! packadd! hlyank
silent! packadd! matchit
silent! packadd! nohlsearch
if has('patch-8.1.0360') | packadd! termdebug | endif
