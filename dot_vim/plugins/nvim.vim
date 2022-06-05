" Dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'b0o/schemastore.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Comment
Plug 'numToStr/Comment.nvim'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/git-conflict.nvim'

" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Tree
Plug 'kyazdani42/nvim-tree.lua'

" Autopair
Plug 'windwp/nvim-autopairs'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-gps'

" SQL
Plug 'nanotee/sqls.nvim'

" cmp plugins
Plug 'hrsh7th/nvim-cmp' " The completion plugin
Plug 'hrsh7th/cmp-buffer' " buffer completions
Plug 'hrsh7th/cmp-path' " path completions
Plug 'hrsh7th/cmp-cmdline' " cmdline completions
Plug 'saadparwaiz1/cmp_luasnip' " snippet completions
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

" snippets
Plug 'L3MON4D3/LuaSnip' " snippet engine
Plug 'rafamadriz/friendly-snippets' " a bunch of snippets to use

" Trouble
Plug 'folke/trouble.nvim'

" Improve the default vim.ui interfaces 
Plug 'nvim-telescope/telescope-ui-select.nvim'

" Debug Adapter Protocol
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'leoluz/nvim-dap-go'
Plug 'mfussenegger/nvim-jdtls'
