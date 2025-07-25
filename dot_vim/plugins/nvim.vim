" Dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'nvimtools/none-ls.nvim'
Plug 'b0o/schemastore.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Comment
Plug 'numToStr/Comment.nvim'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/git-conflict.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'ruifm/gitlinker.nvim'

" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim' " Improve the default vim.ui interfaces 

" Tree
Plug 'nvim-tree/nvim-tree.lua'

" Autopair
Plug 'windwp/nvim-autopairs'

" Nord theme
Plug 'shaunsingh/nord.nvim'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-navic'

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
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }}, {{ name = 'buffer' }}  })

" snippets
Plug 'L3MON4D3/LuaSnip' " snippet engine
Plug 'rafamadriz/friendly-snippets' " a bunch of snippets to use

" Trouble
Plug 'folke/trouble.nvim'

" Debug Adapter Protocol
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'leoluz/nvim-dap-go'
Plug 'mfussenegger/nvim-jdtls'

" Bufferline
" Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" Lua dev
Plug 'folke/neodev.nvim'

" Gopher
Plug 'olexsmir/gopher.nvim'

" todo comments
Plug 'folke/todo-comments.nvim'

" Mini icons
Plug 'echasnovski/mini.icons'

" Local Config
Plug 'MunifTanjim/exrc.nvim'

" Embed Neovim in Chrome, Firefox, Thunderbird & others
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Autolist
Plug 'gaoDean/autolist.nvim'

" Neogit
Plug 'TimUntersberger/neogit'

" Surround
Plug 'kylechui/nvim-surround'

" GitLab
Plug 'MunifTanjim/nui.nvim'
Plug 'harrisoncramer/gitlab.nvim'

" Hurl
Plug 'pfeiferj/nvim-hurl'
autocmd BufRead,BufNewFile *.hurl setlocal filetype=hurl

" Image Viewer as ASCII Art
Plug 'samodostal/image.nvim'

" SQL IDE
Plug 'xemptuous/sqlua.nvim'

" File explorer
Plug 'stevearc/oil.nvim'

" Tailwind CSS
Plug 'luckasRanarison/tailwind-tools.nvim', { 'do': ':UpdateRemotePlugins'}

" Ghost
Plug 'subnut/nvim-ghost.nvim'

" YAML schemas
Plug 'someone-stole-my-name/yaml-companion.nvim'

" Kubernetes
Plug 'ramilito/kubectl.nvim'

" Code Companion
Plug 'olimorris/codecompanion.nvim'
