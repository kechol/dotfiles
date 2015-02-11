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

"" Color scheme
syntax on
set background=dark

