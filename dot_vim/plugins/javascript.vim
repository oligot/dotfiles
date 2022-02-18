Plug 'othree/javascript-libraries-syntax.vim'
Plug 'isRuslan/vim-es6'
Plug 'xojs/vim-xo'

"javascript-libraries-syntax
let g:used_javascript_libs = 'underscore,vue'

" vim-javascript conceal settings.
let g:javascript_conceal_function = "λ"
let g:javascript_conceal_this = "@"
let g:javascript_conceal_return = "<"
let g:javascript_conceal_prototype = "#"

"Vue
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript
autocmd BufRead,BufNewFile *.vue syntax sync fromstart
let g:vue_pre_processors = ['scss', 'typescript']
