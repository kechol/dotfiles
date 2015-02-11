"" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,euc-jp,ucs2le,ucs-2
set langmenu=en_US.utf-8
let $LANG='en_US'

"" Basic settings
set wrap
set wrapscan
set hlsearch
set number
set ruler
set expandtab
set tabstop=2
set shiftwidth=2
set smartcase
set cindent
set smarttab
set backspace=2
set showcmd
set showmode
set noerrorbells
set novisualbell
set cursorline
set autoread
set noswapfile
set nobackup
set nowritebackup
set formatoptions+=mM
set ambiwidth=double
set display+=lastline
set synmaxcol=160
set history=1000
set t_Co=256
set list listchars=eol:$,extends:>,precedes:<,trail:-,tab:>-
set laststatus=2
set statusline=%<%f\ %m\ %h%r%=%-14.(%l,%c%V%)\ [%{&fenc!=''?&fenc:&enc}][%{&ff}]\ %L%8P

"" Key mappings
let g:mapleader=","
map <Enter> o
imap jj <ESC>
imap kk <ESC>
vnoremap <silent> <C-p> "0p<CR>

"" NeoBundle
if filereadable('vim/bundle/neobundle.vim/autoload/neobundle.vim')
  if !1 | finish | endif
  if has('vim_starting')
    if &compatible
      set nocompatible
    endif
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
  call neobundle#begin(expand('~/.vim/bundle/'))

  if exists(':NeoBundle')
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'vim-scripts/sudo.vim'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neomru.vim'
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'w0ng/vim-hybrid'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'editorconfig/editorconfig-vim'
    NeoBundle 'Lokaltog/vim-easymotion'
    NeoBundle 'osyo-manga/vim-over'
    NeoBundle 'ntpeters/vim-better-whitespace'
  endif

  call neobundle#end()
  filetype plugin indent on
  NeoBundleCheck
endif

"" Color scheme
syntax on
if filereadable('vim/bundle/vim-hybrid/colors/hybrid.vim')
  set background=dark
  colorscheme hybrid
endif

"" unite.vim
if filereadable('vim/bundle/unite.vim/autoload/unite.vim')
  let g:unite_enable_start_insert        = 1
  let g:unite_source_history_yank_enable = 1
  let g:unite_enable_ignore_case         = 1
  let g:unite_enable_smart_case          = 1
  imap <silent> <C-p>   <ESC>:<C-u>UniteWithCurrentDir -buffer-name=files file<CR>
  imap <silent> <C-h>   <ESC>:<C-u>Unite buffer file_mru<CR>
  imap <silent> <C-y>   <ESC>:<C-u>Unite history/yank<CR>
  imap <silent> <C-g>   <ESC>:<C-u>Unite grep:. -buffer-name=search-buffer<CR>
  nmap <silent> <C-p>   <ESC>:<C-u>UniteWithCurrentDir -buffer-name=files file<CR>
  nmap <silent> <C-h>   <ESC>:<C-u>Unite buffer file_mru<CR>
  nmap <silent> <C-y>   <ESC>:<C-u>Unite history/yank<CR>
  nmap <silent> <C-g>   <ESC>:<C-u>Unite grep:. -buffer-name=search-buffer<CR>
  au FileType unite nmap <silent> <buffer> <expr> <C-s> unite#do_action('split')
  au FileType unite imap <silent> <buffer> <expr> <C-s> unite#do_action('split')
  au FileType unite nmap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  au FileType unite imap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  if executable('git')
    let g:unite_source_grep_command = 'git'
    let g:unite_source_grep_default_opts = '--no-pager grep -n'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_git_grep_max_candidates = 150
  endif
end

"" syntastic
if filereadable('vim/bundle/syntastic/autoload/syntastic/c.vim')
  let g:syntastic_enable_balloons     = 0
  let g:syntastic_enable_highlighting = 1
  let g:syntastic_auto_loc_list       = 2
  let g:syntastic_quiet_messages      = { 'level': 'warnings' }
  let g:syntastic_python_checkers     = ['pylint']
  let g:syntastic_html_checkers       = ['jshint']
  let g:syntastic_css_checkers        = ['csslint']
  let g:syntastic_csslint_options     = "--warnings=none"
  let g:syntastic_javascript_checkers = ['jshint']
  let g:syntastic_json_checkers       = ['jsonlint']
  let g:syntastic_ruby_checkers       = ['rubocop']
  nmap <silent> <C-l>   <ESC>gg=G:<C-u>SyntasticCheck<CR>
  imap <silent> <C-l>   <ESC>gg=G:<C-u>SyntasticCheck<CR>
endif


"" vim-over
if filereadable('vim/bundle/vim-over/autoload/over.vim')
  nmap <silent> <C-/>   <ESC>:<C-u>OverCommandLine<CR>
endif

"" easymotion
if filereadable('vim/bundle/vim-easymotion/autoload/EasyMotion.vim')
  let g:EasyMotion_keys = 'hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
  let g:EasyMotion_leader_key = ','
  let g:EasyMotion_grouping = 1
  nmap <silent> <C-j> <leader>j
  nmap <silent> <C-k> <leader>k
  hi easymotiontarget ctermbg=none ctermfg=red
  hi easymotionshade  ctermbg=none ctermfg=gray
endif

"" neocomplete.vim
if filereadable('vim/bundle/neocomplete.vim/autoload/neocomplete.vim')
  let g:neocomplete#enable_at_startup        = 1
  let g:neocomplete#enable_smart_case        = 1
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  set omnifunc=syntaxcomplete#Complete
endif

"" vim-fugitive
if filereadable('vim/bundle/vim-fugitive/plugin/fugitive.vim')
  set statusline=%<%f\ %m\ %h%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ [%{&fenc!=''?&fenc:&enc}][%{&ff}]\ %L%8P
  nmap <silent> <C-s>   <ESC>:<C-u>Gstatus<CR>
  imap <silent> <C-s>   <ESC>:<C-u>Gstatus<CR>
endif

