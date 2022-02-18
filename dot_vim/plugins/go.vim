Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

" syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_type_info = 1

" Run all the tests in the current file
autocmd BufEnter *.go nmap <leader>t  <Plug>(go-test)
" Run the current test function only
autocmd BufEnter *.go nmap <leader>tt <Plug>(go-test-func)
" Toggle the coverage profile for the current file
autocmd BufEnter *.go nmap <leader>c  <Plug>(go-coverage-toggle)
" Show the interfaces a type implements 
autocmd BufEnter *.go nmap <leader>ii  <Plug>(go-implements)
" Describe the definition of a given type
autocmd BufEnter *.go nmap <leader>ci  <Plug>(go-describe)
" See the callers of a given function
autocmd BufEnter *.go nmap <leader>cc  <Plug>(go-callers)

" Format
autocmd FileType go map <buffer> <leader>f :GoImports<cr>
