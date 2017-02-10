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

" colorscheme
Plug 'vim-scripts/wombat256.vim'

" status/tabline
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Preserve missing EOL at the end of text files
Plug 'vim-scripts/PreserveNoEOL'

" Maintains a history of previous yanks, changes and deletes
Plug 'vim-scripts/YankRing.vim'

" Show a diff using Vim its sign column
Plug 'mhinz/vim-signify'

call plug#end()

" A helper function to check whether a plugin is enabled
function! s:has_plugged(name)
  return (has_key(g:plugs, a:name) != 0)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on wild menu
set wildmenu

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark

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


""""""""""""""""""""""""""""""""""""
" YankRing
""""""""""""""""""""""""""""""""""""
if s:has_plugged('YankRing.vim')
  let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring'
  let g:yankring_replace_n_pkey='<C-K>'
  let g:yankring_replace_n_nkey='<C-J>'
endif
