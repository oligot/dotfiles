Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Format
autocmd FileType javascript,typescript,vue map <buffer> <leader>f :PrettierAsync<cr>
