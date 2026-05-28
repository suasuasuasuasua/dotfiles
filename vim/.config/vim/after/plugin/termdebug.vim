if exists(':Termdebug')
  autocmd User TermdebugStartPost nnoremap - :call TermDebugSendCommand('down')<CR>
  autocmd User TermdebugStopPost  nmap - <Plug>VinegarUp
endif
