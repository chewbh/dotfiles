"""""""""""""""""""""""""""""""""""""""""""""""""
" Boon Heng Vim Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
  set nocompatible   " allow vim specific settings even if break vi bindings
endif

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
Plugin 'ervandew/supertab'    " use <tab> for all insert completion
Plugin 'BufOnly.vim'          " script to unload all buffers but the current one
Plugin 'wesQ3/vim-windowswap' " swap windows in vim without ruining layout

Plugin 'SirVer/ultisnips'     " snippet for vim (pynvim is needed)
" Plugin 'ncm2/ncm2-ultisnips'
"" Press enter key to trigger snippet expansion
"" The parameters are the same as `:help feedkeys()`
"inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

 "" c-j c-k for moving in snippet
"let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
"let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
"let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
"let g:UltiSnipsRemoveSelectModeMappings = 0

Plugin 'udalov/kotlin-vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'


if has('nvim')               " list of plugins usable in modern vim
  Plugin 'w0rp/ale'
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

" ensure config work for vim + nvim (ttymouse was removed in nvim)
if !has('nvim')
  " name of terminal that support mouse codes if mouse is enabled
  set ttymouse=xterm2
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
set nowrap       " disable text wrap
set linebreak    " break lines when appropriate
set smartindent  " smart autoindenting on new line
set autoindent   " auto indent based on previous line
set backspace=2  " use standard backspace behavior
set laststatus=2 " always display the status line
set cursorline   " enable highlighting of the current line

let g:elite_mode=1 "enable elite mode, no arrows

" enable syntax coloring
syntax enable
syntax on

" autocmd vimenter * NERDTree

" additional key bindings
"map <C-n> :NERDTreeToggle<CR>

function! s:source_file(path, ...) abort
	let use_global = get(a:000, 0, ! has('vim_starting'))

	let abspath = resolve(expand($HOME.'/dotfiles/vim_config/'.a:path))
	if ! use_global
		execute 'source' fnameescape(abspath)
		return
	endif

	let content = map(readfile(abspath),
		\ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
	let tempfile = tempname()
	try
		call writefile(content, tempfile)
		execute printf('source %s', fnameescape(tempfile))
	finally
		if filereadable(tempfile)
			call delete(tempfile)
		endif
	endtry
endfunction

call s:source_file('mappings.vim')

if (has("termguicolors"))
  set termguicolors
endif

let base16colorspace=256
"colorscheme spacegray

" vim-airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
"let g:airline_theme='hybrid'
let g:airline_theme='base16_spacemacs'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 

" syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*



