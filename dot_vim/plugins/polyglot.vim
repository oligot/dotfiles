Plug 'sheerun/vim-polyglot'

"Disable LaTeX-Box (comes with polyglot)
let g:polyglot_disabled = ['latex']

"Treat .sql files as PostgreSQL
let g:sql_type_default = 'pgsql'

"Markdown
let g:vim_markdown_conceal = 0
let g:markdown_fenced_languages = ['html', 'python', 'go', 'vim', 'bash', 'yaml']
let g:vim_markdown_frontmatter = 1
