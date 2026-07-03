if exists('g:loaded_tmux_navigator') | finish | endif
let g:loaded_tmux_navigator = 1

function! s:Navigate(dir)
  let nr = winnr()
  try | execute 'wincmd ' . a:dir | catch | endtry
  if empty($TMUX) || nr != winnr() | return | endif
  call system('tmux select-pane -t ' . shellescape($TMUX_PANE) . ' -' . tr(a:dir, 'hjkl', 'LDUR'))
endfunction

command! -nargs=1 TmuxNavigate call s:Navigate(<q-args>)

nnoremap <silent> <C-h> :<C-U>TmuxNavigate h<CR>
nnoremap <silent> <C-j> :<C-U>TmuxNavigate j<CR>
nnoremap <silent> <C-k> :<C-U>TmuxNavigate k<CR>
nnoremap <silent> <C-l> :<C-U>TmuxNavigate l<CR>

if !empty($TMUX)
  tnoremap <expr> <silent> <C-h> &ft ==# 'fzf' ? "\<C-h>" : "\<C-w>:\<C-U>TmuxNavigate h\<CR>"
  tnoremap <expr> <silent> <C-j> &ft ==# 'fzf' ? "\<C-j>" : "\<C-w>:\<C-U>TmuxNavigate j\<CR>"
  tnoremap <expr> <silent> <C-k> &ft ==# 'fzf' ? "\<C-k>" : "\<C-w>:\<C-U>TmuxNavigate k\<CR>"
  tnoremap <expr> <silent> <C-l> &ft ==# 'fzf' ? "\<C-l>" : "\<C-w>:\<C-U>TmuxNavigate l\<CR>"
endif
