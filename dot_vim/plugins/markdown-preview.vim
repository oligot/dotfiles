" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'shime/vim-livedown'

nmap gm :LivedownToggle<CR>
