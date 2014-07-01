let s:plugin_path = expand("<sfile>:p:h:h")

if !exists("g:nose_runner")
  let g:nose_runner = "os_x_terminal"
endif

if !exists("g:nose_command")
  let s:cmd = "nosetests -s --with-specplugin {test}"

  if has("gui_running") && has("gui_macvim")
    let g:nose_command = "silent !" . s:plugin_path . "/bin/" . g:nose_runner . " '" . s:cmd . "'"
  else
    let g:nose_command = "!clear && echo " . s:cmd . " && " . s:cmd
  endif
endif

function! NoseRunAllTests()
  let l:test = "."
  call NoseSetLastTestCommand(l:test)
  call NoseRunTests(l:test)
endfunction

function! NoseRunCurrentTestFile()
  if NoseInTestFile()
    let l:test = @%
    call NoseSetLastTestCommand(l:test)
    call NoseRunTests(l:test)
  else
    call NoseRunLastTest()
  endif
endfunction

function! NoseRunNearestTest()
  let pos = getpos(".")
  let old_reg = @@
  execute "normal! ?^\\s*def \<cr>wwyw"
  let funcname = @@
  execute "normal! ?^\\s*class \<cr>wyw"
  let classname = @@
  let @@ = old_reg
  call setpos('.', pos)
  if NoseInTestFile()
    let l:test = @% . ":" . classname . "." . funcname
    call NoseSetLastTestCommand(l:test)
    call NoseRunTests(l:test)
  else
    call NoseRunLastTest()
  endif
endfunction

function! NoseRunLastTest()
  if exists("s:last_test_command")
    call NoseRunTests(s:last_test_command)
  endif
endfunction

function! NoseInTestFile()
  return match(expand("%"), "test.*\\.py") != -1
endfunction

function! NoseSetLastTestCommand(test)
  let s:last_test_command = a:test
endfunction

function! NoseUnsetLastTestCommand()
  unlet! s:last_test_command
endfunction

function! NoseRunTests(test)
  execute substitute(g:nose_command, "{test}", a:test, "g")
endfunction
