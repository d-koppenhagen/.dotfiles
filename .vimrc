"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lines of history to remember
set history=500

" Highlight search results
set hlsearch

" Filetype detection, plugins, and indent rules
filetype plugin indent on

" Readability
syntax on
colo pablo

" Use spaces instead of tabs
set expandtab
set softtabstop=4

set autoindent "Use indent from current line for next line
set autoread "Detect when file changes outside of Vim
set smartindent "Be clever when code cues are recognized
set wrap "Wrap lines

" Spell check and line wrap for git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72
