" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'shime/vim-livedown'
Plug 'jkramer/vim-checkbox'

nmap gm :LivedownToggle<CR>
