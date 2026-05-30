setlocal foldmethod=syntax

if executable('c++')
  for s:inc in filter(systemlist('c++ -E -x c++ /dev/null -v 2>&1'), 'v:val =~ "^ /\\S\\+$"')
    execute 'setlocal path+=' . trim(s:inc)
  endfor
endif

function! s:rebuild_indexes() abort
  if exists('s:rebuild_job') && job_status(s:rebuild_job) ==# 'run'
    return
  endif
  let s:rebuild_job = job_start(['sh', '-c', 'ctags -R . && cscope -Rbq'], {
        \ 'exit_cb': function('s:on_rebuild_exit'),
        \ })
endfunction

function! s:on_rebuild_exit(ch, status) abort
  if a:status == 0
    silent! cs reset
  endif
endfunction

augroup tte_index_rebuild
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> call s:rebuild_indexes()
augroup END
