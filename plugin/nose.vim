let s:plugin_path = expand("<sfile>:p:h:h")

if !exists("g:nose_runner")
  let g:nose_runner = "os_x_terminal"
endif

if !exists("g:nose_vimcommand")
  if !exists("g:nose_command")
    let g:nose_command = "nosetests {test}"
  endif

  if has("gui_running") && has("gui_macvim")
    let g:nose_vimcommand = "silent !" . s:plugin_path . "/bin/" . g:nose_runner . " " . shellescape(g:nose_command)
  else
    let g:nose_vimcommand = "!clear && echo " . g:nose_command . " && " . g:nose_command
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
  call search("\\s*def .", "be")
  let funcname = expand("<cword>")
  call search("\\s*class .", "be")
  let classname = expand("<cword>")
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
  execute substitute(g:nose_vimcommand, "{test}", a:test, "g")
endfunction
