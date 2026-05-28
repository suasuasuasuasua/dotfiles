setlocal foldmethod=syntax

if executable('c++')
  for s:inc in filter(systemlist('c++ -E -x c++ /dev/null -v 2>&1'), 'v:val =~ "^ /\\S\\+$"')
    execute 'setlocal path+=' . trim(s:inc)
  endfor
endif
