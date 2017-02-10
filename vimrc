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

call plug#end()

" A helper function to check whether a plugin is enabled
function! s:has_plugged(name)
  return (has_key(g:plugs, a:name) != 0)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark

" colorscheme
colorscheme wombat256mod

" SignColumn should match background
highlight clear SignColumn      


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
