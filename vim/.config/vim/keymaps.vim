inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>
inoremap jk <Esc>

nnoremap <silent> <Leader>l :nohl<CR>
nnoremap <Leader>mm :make<CR>
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>so :source $HOME/.config/vim/vimrc<CR>

" ctags — fzf overrides when available
nnoremap <Leader><Leader> :b<space>
nnoremap <Leader>sf :find<space>
nnoremap <Leader>sg :Grep<space>
nnoremap grd <C-]>
nnoremap grr :Grep <C-r><C-w>
xnoremap grr :<C-u>call <SID>GrepVisual()<CR>

func! s:GrepVisual()
  let l:save = @"
  normal! gvy
  let l:sel = @"
  let @" = l:save
  call feedkeys(':Grep ' . l:sel, 'n')
endfunc
nnoremap <leader>st :tselect /
nnoremap gO :tselect /

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
