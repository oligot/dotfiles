Plug 'mhinz/vim-grepper'

nnoremap <leader>rg :Grepper -tool rg<cr>
nnoremap <leader>* :Grepper -tool rg -cword -noprompt<cr>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
