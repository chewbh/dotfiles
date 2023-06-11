" additional key bindings
map <C-n> :NERDTreeToggle<CR>       " NERD Tree pop up using ctrl+n

map <C-m> :Vista<CR>         

nnoremap <silent> <C-f> :Files<CR>  " fzf search using ctrl+f

" nerd commenter for commenting code using //
nmap // <leader>c<space>
vmap // <leader>cs


" Disable arrow movement, resize splits instead.
"if get(g:, 'elite_mode')
"	nnoremap <Up>    :resize +2<CR>
"	nnoremap <Down>  :resize -2<CR>
"	nnoremap <Left>  :vertical resize +2<CR>
"	nnoremap <Right> :vertical resize -2<CR>
"endif