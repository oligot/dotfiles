" Dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'b0o/schemastore.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'onsails/lspkind.nvim'

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
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim' " Improve the default vim.ui interfaces 

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
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip' " snippet completions

" snippets
Plug 'L3MON4D3/LuaSnip' " snippet engine
Plug 'rafamadriz/friendly-snippets' " a bunch of snippets to use

" Trouble
Plug 'folke/trouble.nvim'

" Debug Adapter Protocol
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'leoluz/nvim-dap-go'
Plug 'mfussenegger/nvim-jdtls'

" Bufferline
" Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" Lua dev
Plug 'folke/lua-dev.nvim'

" todo comments
Plug 'folke/todo-comments.nvim'
