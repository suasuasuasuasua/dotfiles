if exists(':Termdebug')
  autocmd User TermdebugStartPost nnoremap - :call TermDebugSendCommand('down')<CR>
  autocmd User TermdebugStopPost  nnoremap - :Explore<CR>
endif
