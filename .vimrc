"""""""""""""""""""""""""""""""""""""""""""""""""
" Boon Heng Vimrc Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible   " allow vim specific settings even if break vi bindings
set encoding=utf8

" disable file type for vundle
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" base16 color
Plugin 'chriskempson/base16-vim'

" utility
Plugin 'scrooloose/nerdtree'  " tree explorer
Plugin 'majutsushi/tagbar'    " class outline viewer (browse tags of the current file)



if has('nvim')               " list of plugins usable in modern vim
  Plugin 'w0rp/ale'
  "Plugin 'roxma/nvim-completion-manager' 
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help on Vundle
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ

"""""""""""""""""""""""""""
" other settings
"""""""""""""""""""""""""""
" enable the use of base16 color for vim
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" enable detection of pig scripts
augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END

" treat tab as 2 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab 

set mouse-=a     " avoid entering visual mode in vim with mouse selection 
set incsearch    " find as you type
set ignorecase   " ignore case in search
set history=300  " number of commands to remember in history
set hlsearch     " highlight matches in search
set scrolloff=5  " no. of lines to keep above/below cursor
set smartcase    " only ignore case when all letters are lowercase
set number       " show line numbers
set ruler        " show line and column number
set wildmode=longest,list " complete longest string, then list alternative
set fileformats=unix  " use Unix line endings
set formatoptions=1   " don't wrap text after a 1-letter word
set linebreak    " break lines when appropriate
set smartindent  " smart autoindenting on new line
set autoindent   " auto indent based on previous line
set backspace=2  " use standard backspace behavior

" enable syntax coloring
syntax enable
syntax on

" autocmd vimenter * NERDTree

" additional key bindings
map <C-n> :NERDTreeToggle<CR>




