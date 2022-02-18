Plug 'tpope/vim-dispatch'

autocmd FileType go let b:dispatch = 'go test'
nnoremap <Leader><CR> :Dispatch<CR>
