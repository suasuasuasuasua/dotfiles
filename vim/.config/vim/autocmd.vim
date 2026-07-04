augroup vimrc
  autocmd!
  " Return to last edit position when opening files
  autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
  autocmd FocusGained,BufEnter * if getcmdwintype() == '' | checktime | endif
augroup END
