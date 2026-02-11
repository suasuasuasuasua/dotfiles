"https://github.com/junegunn/fzf.vim
if exists('g:loaded_fzf_vim')
  nnoremap <silent> <Leader><Leader> :Buffers<CR>
  nnoremap <silent> <Leader>s. :History<CR>
  nnoremap <silent> <Leader>s/ :BLines<CR>
  nnoremap <silent> <Leader>sc :Commands<CR>
  nnoremap <silent> <Leader>sf :Files<CR>
  nnoremap <silent> <Leader>sg :Rg<CR>
  nnoremap <silent> <Leader>sh :Helptags<CR>
  nnoremap <silent> <Leader>sk :Maps<CR>
  nnoremap <silent> <Leader>st :Tags<CR>
endif
