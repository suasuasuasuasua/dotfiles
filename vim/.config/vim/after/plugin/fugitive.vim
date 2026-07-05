"https://github.com/tpope/vim-fugitive
if exists('g:loaded_fugitive')
  nnoremap <silent> <Leader>gg :tab Git<CR>
  nnoremap <silent> <Leader>go :tab Git log --oneline --graph --decorate<CR>
  nnoremap <silent> <Leader>hb :Git blame<CR>
  nnoremap <silent> <Leader>hd :Git diff --cached -- %<CR>
  nnoremap <silent> <Leader>hD :Git diff HEAD -- %<CR>
endif
