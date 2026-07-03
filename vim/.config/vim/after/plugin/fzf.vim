"https://github.com/junegunn/fzf.vim
if exists('g:loaded_fzf_vim')
  nnoremap <silent> <Leader><Leader> :Buffers<CR>
  nnoremap <silent> <Leader>s. :History<CR>
  nnoremap <silent> <Leader>s: :History:<CR>
  nnoremap <silent> <Leader>s/ :History/<CR>
  nnoremap <silent> <Leader>sc :Commands<CR>
  nnoremap <silent> <Leader>sf :Files<CR>
  nnoremap <silent> <Leader>sg :Rg<CR>
  nnoremap <silent> <Leader>sG :GGrep<CR>
  nnoremap <silent> <Leader>sh :Helptags<CR>
  nnoremap <silent> <Leader>sk :Maps<CR>
  nnoremap <silent> <Leader>sn :Files $HOME/.config/vim/<CR>
  nnoremap <silent> <Leader>st :Tags<CR>

  " An action can be a reference to a function that processes selected lines
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

  let g:fzf_history_dir = '~/.local/share/fzf-history'

  " git grep wrapper
  command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
    \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-l> <plug>(fzf-complete-line)
endif
