"Set mapleader
let mapleader = " "
let g:mapleader = " "
let maplocalleader = " "
let g:maplocalleader = " "

"Fast saving
nmap <leader>w :w!<cr>

"Save read-only files
cmap w!! w !sudo tee % >/dev/null

"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vimrc<cr>

"Buffers
command Bd :up | %bd | e#
nnoremap <silent> <leader>d :bdelete<CR>
nnoremap <leader>, <C-^>
map <leader>Q :bufdo bdelete<cr>
map <leader>D :Bd<cr>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Open the current file in the default program
nmap <leader>x :!xdg-open %<cr><cr>

"Catch trailing whitespace
nmap <silent> <leader>c :set nolist!<CR>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>

" Make `jj` and `jk` throw you into normal mode
inoremap jj <esc>
inoremap jk <esc>

"Move selected block up/down in Visual block mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Vertical split
nnoremap <silent> <leader>vs <C-w>v

" Clear the highlighting of :set hlsearch.
nmap <leader>. :nohlsearch<cr>

"Consistent downwards/upwards
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" reselect pasted text
nnoremap gp `[v`]
