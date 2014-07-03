# nose.vim

This is a lightweight nosetests runner for Vim and MacVim.  The
code has been ported over from
[thoughtbot/vim-rspec](http://github.com/thoughtbot/vim-rspec) so it can work with Nose.

## Installation

Recommended installation with [vundle](https://github.com/gmarik/vundle):

```vim
Bundle 'chongkim/vim-nose'
```

If using zsh on OS X it may be necessary to move `/etc/zshenv` to `/etc/zshrc`.

## Configuration

### Key mappings

Add your preferred key mappings to your `.vimrc` file.

```vim
" nose.vim mappings
map <Leader>rt :call NoseRunCurrentTestFile()<CR>
map <Leader>rs :call NoseRunNearestTest()<CR>
map <Leader>rl :call NoseRunLastTest()<CR>
map <Leader>ra :call NoseRunAllTests()<CR>
```

### Custom command

Overwrite the `g:nose_command` variable to run a custom command.

Example:

```vim
let g:nose_command = "nosetests -s --with-specplugin {test}"
```

You can also overwrite the `g:nose_vimcommand`, which will execute any vim command.

This `g:nose_vimcommand` variable can be used to support any number of test
runners or pre-loaders. For example, to use
[Dispatch](https://github.com/tpope/vim-dispatch):

```vim
let g:rspec_vimcommand = "Dispatch nosetests {test}"
```
Or, [Dispatch](https://github.com/tpope/vim-dispatch) and
[Zeus](https://github.com/burke/zeus) together:

```vim
let g:nose_vimcommand = "compiler nosetests | set makeprg=zeus | Make nosetests {test}"
```

### Custom runners

Overwrite the `g:nose_runner` variable to set a custom launch script. At the
moment there are two MacVim-specific runners, i.e. `os_x_terminal` and
`os_x_iterm`. The default is `os_x_terminal`, but you can set this to anything
you want, provided you include the appropriate script inside the plugin's
`bin/` directory.

#### iTerm instead of Terminal

If you use iTerm, you can set `g:nose_runner` to use the included iterm
launching script. This will run the tests in the last session of the current
terminal.

```vim
let g:nose_runner = "os_x_iterm"
```

Credits
-------

nose.vim is maintained by Chong Kim.

Thanks to thoughtbot for vim-rspec.

## License

nose.vim is copyright © 2014 Chong Kim. It is free software, and may be
redistributed under the terms specified in the `LICENSE` file.
