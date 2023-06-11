" additional key bindings
map <C-n> :NERDTreeToggle<CR>

map <C-m> :TagbarToggle<CR>

nnoremap <silent> <C-f> :Files<CR>  " fzf search

" Disable arrow movement, resize splits instead.
"if get(g:, 'elite_mode')
"	nnoremap <Up>    :resize +2<CR>
"	nnoremap <Down>  :resize -2<CR>
"	nnoremap <Left>  :vertical resize +2<CR>
"	nnoremap <Right> :vertical resize -2<CR>
"endif