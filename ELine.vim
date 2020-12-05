function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "[NORMAL]"
  elseif l:mode==?"v"
    return "[VISUAL]"
  elseif l:mode==#"i"
    return "[INSERT]"
  elseif l:mode==#"R"
    return "[REPLACE]"
  elseif l:mode==?"s"
    return "[SELECT]"
  elseif l:mode==#"t"
    return "[TERMINAL]"
  elseif l:mode==#"c"
    return "[COMMAND]"
  elseif l:mode==#"!"
    return "[SHELL]"
  endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END


set statusline=
set statusline+=%#StatusLineTerm#
set statusline+=\ %M " is a + if a file is changed since last save
set statusline+=\ %{StatuslineMode()} "displays the 
set statusline+=%#Search#
set statusline+=\ %F  " filename of the file being edited
set statusline+=%#GitGutterAdd#
set statusline+=%{b:gitbranch}
set statusline+=%#StatusLineNC#
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=%#Type#
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " percentage down the page 
set statusline+=\ %#WildMenu# 
set statusline+=\[%{&fileformat}\] " utf-8 usually
set statusline+=%#CursorLineNr#
set statusline+=\ %p%%
set statusline+=\ %l:%c

