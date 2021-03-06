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

" utility
Plugin 'scrooloose/nerdtree'  " tree explorer
Plugin 'majutsushi/tagbar'    " class outline viewer (browse tags of the current file)
Plugin 'ervandew/supertab'    " use <tab> for all insert completion
Plugin 'BufOnly.vim'          " script to unload all buffers but the current one
Plugin 'jeetsukumaran/vim-buffergator' " list, select, and switch between buffers
Plugin 'wesQ3/vim-windowswap' " navigate or swap windows in vim without ruining layout
Plugin 'benmills/vimux'       " easily interact with tmux from vim
" Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf.vim'     " enable use of fzf for vim (see below)
Plugin 'junegunn/fzf'         " fuzzy finder and code search
Plugin 'godlygeek/tabular'    " tool for line up text
Plugin 'gilsondev/searchtasks.vim' " search labels often used as TODO, FIXME, and XXX
Plugin 'tpope/vim-dispatch'   " kick off builds and test suites using async adapter (e.g. tmux, screen)

" programming support
Plugin 'jiangmiao/auto-pairs' " automatically insert auto-close chars
" Plugin 'Townk/vim-autoclose'  " automatically insert auto-close chars
Plugin 'tomtom/tcomment_vim'  " extensible & universal code comment plugin
Plugin 'tobyS/vmustache'      " enable use of logic-less mustache template system
Plugin 'janko-m/vim-test'     " run test in vim
Plugin 'neomake/neomake'      " async linting and make framework
Plugin 'udalov/kotlin-vim'

" markdown or general writing
Plugin 'reedes/vim-pencil'    " tweak vim to ease writing using vim
Plugin 'plasticboy/vim-markdown' " syntax highlightin, rules, mappings for markdown

" git support
Plugin 'tpope/vim-fugitive'   " git wrapper in vim
Plugin 'kablamo/vim-git-log'  " view git log interactively, side by side diffs "
Plugin 'gregsexton/gitv'

if has('nvim')               " list of plugins usable in modern vim
  Plugin 'w0rp/ale'           " syntax checker
endif

Plugin 'SirVer/ultisnips'     " snippet for vim (pynvim is needed)
" Plugin 'honza/vim-snippets'                   " ignore (snippet for vim, python not needed)
" Plugin 'ncm2/ncm2-ultisnips'
"" Press enter key to trigger snippet expansion
"" The parameters are the same as `:help feedkeys()`
"inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

 "" c-j c-k for moving in snippet
"let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
"let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
"let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
"let g:UltiSnipsRemoveSelectModeMappings = 0

Plugin 'chriskempson/base16-vim'         " base 16 color
Plugin 'vim-airline/vim-airline'         " beautiful status/tagline
Plugin 'vim-airline/vim-airline-themes'  " theme for vim-airline
Plugin 'ryanoasis/vim-devicons'          " add file type glyphs
Plugin 'AnsiEsc.vim'                     " support ansi escape sequences

Plugin 'morhetz/gruvbox'                 " Retro groove color scheme for Vim
Plugin 'dracula/vim', {'rtp': 'vim/'}    " dark theme
Plugin 'junegunn/limelight.vim'          " hyperfocus-writing
Plugin 'romainl/Apprentice'              " dark, low-contrast, color scheme
Plugin 'Lokaltog/vim-distinguished'      " another dark theme
Plugin 'w0ng/vim-hybrid'                 " dark color theme from tomorrow-night
Plugin 'AlessandroYorba/Sierra'          " dark color theme
Plugin 'ajh17/Spacegray.vim'             " loosely based on spacegray color scheme

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

""""""""""""""""""""""""""""
" utility functions
""""""""""""""""""""""""""""

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


"""""""""""""""""""""""""""
" other settings
"""""""""""""""""""""""""""
" OSX stupid backspace fix
set backspace=indent,eol,start

" ensure config work for vim + nvim (ttymouse was removed in nvim)
if !has('nvim')
  " name of terminal that support mouse codes if mouse is enabled
  set ttymouse=xterm2
endif

" enable detection of pig scripts
augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END

" Markdown Syntax Support
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" treat tab as 2 spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab 

"se mouse+=a
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

""""""""""""""""""""""""""""""""""""""
nnoremap <C-p> :Files<Enter>
if has('nvim')
  aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  aug END
end
""""""""""""""""""""""""""""""""""""""


" autocmd vimenter * NERDTree

" additional key bindings
"map <C-n> :NERDTreeToggle<CR>

call s:source_file('mappings.vim')

""""""""""""""""""""""""""""""""""""""""""""""""""""
" color, style and theme configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
set background=dark

" neovim/vim true color support
if (has("termguicolors"))
  set termguicolors
endif

if filereadable(expand("~/.vimrc_background"))
  " enable the use of base16 color for vim
  " access colot present in 256 colorspace
  let base16colorspace=256
  source ~/.vimrc_background
endif

" color scheme
colorscheme spacegray
let g:spacegray_underline_search = 1
let g:spacegray_use_italics = 1
"let g:spacegray_italicize_comments = 1


" vim-airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
let g:airline_theme='hybrid'
" let g:airline_theme='base16_spacemacs'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 

" syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1



" Disable arrow movement, resize splits instead.
"if get(g:, 'elite_mode')
"	nnoremap <Up>    :resize +2<CR>
"	nnoremap <Down>  :resize -2<CR>
"	nnoremap <Left>  :vertical resize +2<CR>
"	nnoremap <Right> :vertical resize -2<CR>
"endif

