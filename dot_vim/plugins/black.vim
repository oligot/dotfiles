Plug 'psf/black', { 'branch': 'stable', 'for': 'python' }

let g:black_linelength=79

autocmd FileType python map <buffer> <leader>f :Black<cr>
