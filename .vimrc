" Centralize backups, swapfiles and undo history
if empty(glob('~/.vim/tmp'))
    silent !mkdir -p ~/.vim/tmp
endif
set directory=$HOME/.vim/tmp

if empty(glob('~/.vim/undo'))
    silent !mkdir -p ~/.vim/undo
endif
set directory=$HOME/.vim/undo

if empty(glob('~/.vim/backups'))
    silent !mkdir -p ~/.vim/backups
endif
set directory=$HOME/.vim/backups

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add syntastic
" Plugin 'scrooloose/syntastic'
" Add emmet
Plugin 'mattn/emmet-vim'
" Add React syntax
Plugin 'mgechev/vim-jsx'
" Add vim-surround
Plugin 'tpope/vim-surround'
" Add NERDTree
"Plugin 'scrooloose/nerdtree'
" Add MatchTagAlways
Plugin 'valloric/MatchTagAlways'
" Add coffeescript syntax
Plugin 'kchmck/vim-coffee-script'
" Add awesome color scheme
Plugin 'mgechev/stylish'
" Add Seti_UI color scheme
Plugin 'trusktr/seti.vim'
" Better integration with tmux
Plugin 'christoomey/vim-tmux-navigator'
" Add go support
Plugin 'fatih/vim-go'
" Add TypeScript
Plugin 'leafgarland/typescript-vim'
" Add auto formatter
Plugin 'Chiel92/vim-autoformat'
" Add Goyo for distraction free coding
Plugin 'junegunn/goyo.vim'
" Add limelight for better Goyo experience
Plugin 'junegunn/limelight.vim'
" Add airline
Plugin 'vim-airline/vim-airline'
" Add airline theme
Plugin 'vim-airline/vim-airline-themes'
" Add Nord theme for vim
Plugin 'arcticicestudio/nord-vim'
call vundle#end()

inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

filetype plugin indent on    " required

" Enhance command-line completion
" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard+=unnamed
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Set smartindent
set smartindent
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Set spaces indentation
function SetIndent(n)
  let &tabstop=a:n
  let &shiftwidth=a:n
  let &softtabstop=a:n
endfunction
" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Use 2 spaces by default
call SetIndent(2)
set expandtab
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Scroll 8 lines at a time
set scrolljump=8
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
" Automatic commands
if has("autocmd")
  " Enable filetype plugin
  " filetype plugin on
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  autocmd BufNewFile,BufRead *.es6 setfiletype javascript syntax=javascript
  autocmd BufNewFile,BufRead *.es7 setfiletype javascript syntax=javascript
  autocmd BufNewFile,BufRead *.tsx setfiletype typescript syntax=typescript
  " Set appropriate linters
  " Treat .md files as .markdown
  autocmd BufNewFile,BufRead *.md set syntax=markdown
  " Start NERDTree automatically
  "autocmd VimEnter * NERDTree
  " Enable emmet for JavaScript and CSS files
  autocmd FileType html,css EmmetInstall
  " Indentation for CSS files
  autocmd BufNewFile,BufRead *.css,*.py call SetIndent(4)
endif
" Set stylish as color scheme
syntax enable
set background=dark
colorscheme nord
" Emmet
let g:user_emmet_install_global = 0
" Toggle NERDTree
"nnoremap <C-e> :NERDTreeToggle<CR>
" Show hidden files in NERDTree
"let NERDTreeShowHidden=1

nnoremap <S-j> :m .+1<CR>
nnoremap <S-k> :m .-2<CR>
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv

" To spell check all git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG set spell

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

set laststatus=2
set t_Co=256"

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" imap <Tab> <C-P>

" Emmet uses spaces instead of tabs
let g:user_emmet_settings = {
\  'html' : {
\    'indentation' : '  '
\  }
\}

" Change the var declaration from multiline to single line
noremap <leader>v $r;^hhrrhrahrv
" Autoformat
noremap <F3> :Autoformat<CR>

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Powerline
set laststatus=2
set t_Co=256
