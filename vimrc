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
call plug#end()

" A helper function to check whether a plugin is enabled
function! s:has_plugged(name)
  return (has_key(g:plugs, a:name) != 0)
endfunction
