"https://github.com/tpope/vim-fugitive
if exists('g:loaded_fugitive')
  nnoremap <silent> <Leader>lg :tab Git<CR>
  nnoremap <silent> <Leader>hb :Git blame<CR>
  nnoremap <silent> <Leader>hd :Git diff --cached -- %<CR>
  nnoremap <silent> <Leader>hD :Git diff HEAD -- %<CR>
endif
