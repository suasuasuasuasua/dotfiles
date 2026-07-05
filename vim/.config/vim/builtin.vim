try | packadd! comment | catch | silent! packadd! vim-commentary | endtry
if has('editorconfig') | packadd! editorconfig | endif
silent! packadd! cfilter
silent! packadd! helptoc
silent! packadd! hlyank
silent! packadd! matchit
silent! packadd! nohlsearch
silent! packadd! termdebug

"show long listing for netrw
let g:netrw_liststyle = 1
