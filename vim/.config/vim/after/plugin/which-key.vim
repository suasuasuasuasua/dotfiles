if exists('g:loaded_vim_which_key')
  nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
  nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

  let g:which_key_map = {}
  let g:which_key_map[' '] = '[ ] Find existing buffers'
  let g:which_key_map.l = 'No-highLight'
  let g:which_key_map.m = { 'name' : '[M]ake' }
  let g:which_key_map.m.m = '[M]ake'
  let g:which_key_map.s = { 'name' : '[S]earch' }
  let g:which_key_map.s['.'] = '[S]earch Recent Files'
  let g:which_key_map.s['/'] = '[S]earch [/] Search history'
  let g:which_key_map.s.c = '[S]earch [C]ommands'
  let g:which_key_map.s.f = '[S]earch [F]iles'
  let g:which_key_map.s.g = '[S]earch by [G]rep'
  let g:which_key_map.s.h = '[S]earch [H]elptags'
  let g:which_key_map.s.k = '[S]earch [K]eymaps'
  let g:which_key_map.s.n = '[S]earch [N]vim config files'
  let g:which_key_map.s.t = '[S]earch [T]ags'
  let g:which_key_map.s[':'] = '[S]earch command history'
  let g:which_key_map.s.o = 'Source vimrc'
  call which_key#register('<Space>', "g:which_key_map")
endif
