""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim configuration skeleton
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/tpope/vim-sensible
runtime! plugin/sensible.vim


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Runtime Environment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" => General

" Intelligently reopen files at your last edit position in Vim
Plug 'dietsche/vim-lastplace'

" Show a diff using Vim its sign column
Plug 'mhinz/vim-signify'

" Vim plugin for detecting indentation of source code
"Plug 'myint/indent-finder'
Plug 'vim-scripts/yaifa.vim'

" lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Preserve missing EOL at the end of text files
Plug 'vim-scripts/PreserveNoEOL'

" Maintains a history of previous yanks, changes and deletes
Plug 'vim-scripts/YankRing.vim'

" Asynchronous Lint Engine
Plug 'w0rp/ale'

" a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Pasting in Vim with indentation adjusted to destination context
Plug 'sickill/vim-pasta'

" A vim plugin to display the indention levels with thin vertical lines
Plug 'yggdroot/indentline'

" => Filetypes

" Jinja plugins for vim (syntax and indent)
Plug 'lepture/vim-jinja'

" CoffeeScript support for vim
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" Vastly improved Javascript indentation and syntax support in Vim
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" React JSX syntax highlighting and indenting for vim.
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" Using the jedi autocompletion library for VIM
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box.
Plug 'python-mode/python-mode', { 'for': 'python' }

" => Colorschemes

" Wombat for 256 color xterms
Plug 'vim-scripts/wombat256.vim'

call plug#end()

" A helper function to check whether a plugin is enabled
function! s:has_plugged(name)
  return (has_key(g:plugs, a:name) != 0)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
let mapleader=","
let g:mapleader=","

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Clipboard (from spf13)
"
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Encoding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,euc-jp,euc-kr,big5,gb18030,latin1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on wild menu
set wildmenu

" Set completion mode as Zsh's style
" 1st TAB: complete longest common string
" 2nd TAB: start wild menu if it is enabled
" 3rd and later TABs: complete the next full match in wild menu
set wildmode=longest:full,full

" Always show current position
set ruler

" Change buffer - without saving
set hidden

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search things
set hlsearch

" Make search act like search in modern browsers
set incsearch

" Set magic on, for regular expressions
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" Show line number
set number

" Enable the use of the mouse
" The xterm handling of the mouse buttons can still be used by keeping
" the shift key pressed.
set mouse=a

" Highlight the screen line of the cursor
set cursorline

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Always show SignColumn
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" Better autochdir
autocmd BufEnter * silent! lcd %:p:h


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
set termguicolors

" colorscheme
colorscheme wombat256mod

" SignColumn should match background
highlight clear SignColumn


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off
set nobackup

" Persistent undo
set undodir=~/.vim/tmp/undo
set undofile

" Swap file
set directory=~/.vim/tmp/swap

" netrw
let g:netrw_home=$HOME.'/.vim/tmp/netrw'

" viminfo
set viminfo+=n~/.vim/tmp/viminfo


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around lines, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch between buffers
map <C-H> :bp<CR>
map <C-L> :bn<CR>

" Treat long lines as break lines (useful when moving around in them)
nnoremap <silent> k gk
nnoremap <silent> j gj


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" PreserveNoEOL
"""""""""""""""""""""""""""""""""""""""
if s:has_plugged('PreserveNoEOL')
  let g:PreserveNoEOL=1
endif

"""""""""""""""""""""""""""""""""""""""
" vim-airline
"""""""""""""""""""""""""""""""""""""""
if s:has_plugged('vim-airline')
  let g:airline_left_sep=''
  let g:airline_right_sep=''
  let g:airline_left_alt_sep=''
  let g:airline_right_alt_sep=''
  let g:airline_theme='powerlineish'
  let g:airline#extensions#tabline#enabled=1
endif

"""""""""""""""""""""""""""""""""""""""
" YankRing
"""""""""""""""""""""""""""""""""""""""
if s:has_plugged('YankRing.vim')
  let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring'
  let g:yankring_replace_n_pkey='<C-K>'
  let g:yankring_replace_n_nkey='<C-J>'
endif

"""""""""""""""""""""""""""""""""""""""
" ale
"""""""""""""""""""""""""""""""""""""""
if s:has_plugged('ale')
  let g:ale_linters = {
\   'python': ['flake8'],
\   'html': ['htmlhint'],
\ }
endif

"""""""""""""""""""""""""""""""""""""""
" python-mode
"""""""""""""""""""""""""""""""""""""""
if s:has_plugged('python-mode')
  let g:pymode_folding=0
  let g:pymode_lint=0
  let g:pymode_doc=0
  let g:pymode_rope=0
  let g:pymode_options_colorcolumn=0
endif

"""""""""""""""""""""""""""""""""""""""
" jedi-vim
"""""""""""""""""""""""""""""""""""""""
if s:has_plugged('jedi-vim')
  setlocal completeopt-=preview
endif


"""""""""""""""""""""""""""""""""""""""
" vim-jsx
"""""""""""""""""""""""""""""""""""""""
if s:has_plugged('vim-jsx')
  let g:jsx_ext_required=0
endif
