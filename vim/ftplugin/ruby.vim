set tabstop=2
set shiftwidth=2

augroup rspec
    autocmd!
    autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
