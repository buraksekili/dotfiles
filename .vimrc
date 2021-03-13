set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'itchyny/vim-gitbranch'
Plugin 'rhysd/vim-clang-format'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_theme='wombat'
let g:airline_section_b = '%{gitbranch#name()}'

let g:clang_format#style_options = {
            \ "IndentWidth" : "4"}
let g:clang_format#auto_format=1

call vundle#end()            " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch cursor type between Insert and Normal Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" To enable <C-S> check this thread.
" https://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

nnoremap <C-j> o<Esc>
nnoremap <C-k> O<Esc>

nnoremap <F3> :source ~/.vimrc<Esc>

nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smarttab

set shiftwidth=4
set tabstop=4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set incsearch
set mouse+=a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Font & Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme badwolf
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rest
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set shortmess+=I
set number
set relativenumber
set laststatus=2
set backspace=indent,eol,start
set hidden
set noerrorbells visualbell t_vb=


