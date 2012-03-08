""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim configuration skeleton
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim/vimrc_skeleton.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Runtime Environment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Activate pathogen
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set how many lines of history Vim has to remember
set history=1000

" With a map leader it's possible to do extra key combinations
let g:mapleader=","

" Fast editing of the .vimrc
map <Leader>e :e! ~/.vim/vimrc<CR>

" When vimrc is edited, reload it
autocmd! BufWritePost vimrc source ~/.vim/vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on wild menu
set wildmenu

" Always show current position
set ruler

" The commandbar height
set cmdheight=2

" Change buffer - without saving
set hidden

" Ignore case when searching
set ignorecase
set smartcase

" Highlight search things
set hlsearch

" Make search act like search in modern browsers
set incsearch

" Set magic on, for regular expressions
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink
set matchtime=2

" Show line number
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 256 Colors Theme
if $TERM =~ '-256color$'
  colorscheme wombat256mod
else
  colorscheme default
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off
set nobackup

" Persistent undo
set undodir=~/.vim/undodir
set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Quickfix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>cc :botright cope<CR>
map <Leader>n :cnext<CR>
map <Leader>p :cprevious<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Encoding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,big5,euc-jp,euc-kr,latin1

" Set terminal encoding to GB18030
map <Leader>tg :set termencoding=gb18030<CR>

" Set terminal encoding to UTF-8, same as encoding option
map <Leader>tu :set termencoding=<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show status line
set laststatus=2

" Use compatible symbols
let Powerline_symbols="compatible"

" Insert the charcode segment before the fileformt segment
call Pl#Theme#InsertSegment('charcode', 'before', 'fileformat')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing whitespace
function! DeleteTrailingWS()
  if (&bin > 0)
    return
  endif

  let save_cursor = getpos(".")
  %substitute/\s\+$//ge
  nohlsearch
  call setpos(".", save_cursor)
endfunc
map <F12> :call DeleteTrailingWS()<CR>

" Switch between buffers
map <C-H> :bp<CR>
map <C-L> :bn<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""
" AutoTag
""""""""""""""""""""""""""""""""""""
let g:autotagCtagsCmd="ctags --sort=yes --c++-kinds=+lpx --fields=+aiKSz --extra=+q"

""""""""""""""""""""""""""""""""""""
" Buffer Explorer
""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1

""""""""""""""""""""""""""""""""""""
" Mini Buffer Explorer
""""""""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget=1

""""""""""""""""""""""""""""""""""""
" Taglist
""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
