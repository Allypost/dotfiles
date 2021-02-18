set number relativenumber
" set mouse=a

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set cindent
set shell=/bin/zsh
set nocompatible              " be iMproved, required

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END



nnoremap <silent> <c-_> :set hlsearch!<cr>
