"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File: ~/.vimrc (Vim configuration file)
" Maintainer: Olivier Ligot <oligot at gmail.com>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible

"Keep a .viminfo file.
set viminfo='1000,f1,<500  

"Set mapleader
let mapleader = " "
let g:mapleader = " "
let maplocalleader = " "
let g:maplocalleader = " "

"Fast saving
nmap <leader>w :w!<cr>

"Save read-only files
cmap w!! w !sudo tee % >/dev/null

"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

map <leader>Q :bufdo bdelete<cr>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Open the current file in the default program
nmap <leader>x :!xdg-open %<cr><cr>

"When editing a file, always jump to the last known cursor position.
"Don't do it when the position is invalid or when inside an event handler
"(happens when dropping a file on gvim).
autocmd BufReadPost *
	 \ if line("'\"") > 0 && line("'\"") <= line("$") |
	 \   exe "normal! g`\"" |
	 \ endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256

"Highlight current
set cursorline

"Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

"Color column
hi ColorColumn ctermbg=lightgrey guibg=lightgrey


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Wildmode
set wildmode=list:longest

"The commandbar is 1 high
set cmdheight=1

"Show line number
set number
set relativenumber

"Do not redraw, when running macros.. lazyredraw
set lazyredraw

"Change buffer - without saving
set hid

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"Catch trailing whitespace
nmap <silent> <leader>c :set nolist!<CR>

"How many tenths of a second to blink
set mat=2

"Don't show mode on the last line
set noshowmode

"General conceal settings
set conceallevel=1
set concealcursor=nc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set colorcolumn=81
set textwidth=80
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set cino=>5n-3f0^-2{2
set modeline

augroup filetype
	au BufRead *.m        set ft=mercury
augroup END

"autocmd BufNewFile,BufRead *.json set ft=javascript

set lbr
set tw=500

   """"""""""""""""""""""""""""""
   " Indent
   """"""""""""""""""""""""""""""

   "C-style indeting
   set cindent

   "Wrap lines
   set wrap


"When doing tab completion, give the following files lower priority. You may
"wish to set 'wildignore' to completely ignore files, and 'wildmenu' to enable
"enhanced tab completion. These can be done in the user vimrc file.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo

"When displaying line numbers, don't use an annoyingly wide number column. This
"doesn't enable line numbers -- :set number will do that. The value given is a
"minimum width to use for the number column, not a fixed size.
if v:version >= 700
	set numberwidth=3
endif
"}}}

"{{{ Syntax highlighting settings
"Switch syntax highlighting on, when the terminal has colors
"Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	set hlsearch
endif
"}}}


set autochdir

"Copy and paste from clipboard
if has('unnamedplus')
  set clipboard=unnamedplus
endif

set backupcopy=yes

"Maintain undo history between sessions
set undofile
set undodir^=~/.vim/undo//

set directory^=~/.vim/swp//
set backupdir^=~/.vim/backup//

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>

" Make `jj` and `jk` throw you into normal mode
inoremap jj <esc>
inoremap jk <esc>

"Update time
set updatetime=1000

"comments
set comments=sl:/*,mb:*,elx:*/

"Buffers
nnoremap <silent> <leader>d :bdelete<CR>
nnoremap <leader>, <C-^>

"Move selected block up/down in Visual block mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"vv to generate new vertical split
nnoremap <silent> <leader>q <C-w>v

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
source ~/.vim/plugins/airline.vim
source ~/.vim/plugins/auto-pairs.vim
source ~/.vim/plugins/black.vim
source ~/.vim/plugins/choosewin.vim
source ~/.vim/plugins/clang-format.vim
source ~/.vim/plugins/coc.vim
source ~/.vim/plugins/commentary.vim
source ~/.vim/plugins/dadbod.vim
source ~/.vim/plugins/dispatch.vim
source ~/.vim/plugins/editorconfig.vim
source ~/.vim/plugins/emmet.vim
source ~/.vim/plugins/expand-region.vim
source ~/.vim/plugins/fugitive.vim
source ~/.vim/plugins/fzf.vim
source ~/.vim/plugins/git.vim
source ~/.vim/plugins/go.vim
source ~/.vim/plugins/grepper.vim
source ~/.vim/plugins/incsearch.vim
source ~/.vim/plugins/javascript.vim
source ~/.vim/plugins/jedi.vim
source ~/.vim/plugins/markdown-preview.vim
source ~/.vim/plugins/matchup.vim
source ~/.vim/plugins/maximizer.vim
source ~/.vim/plugins/mkdir.vim
source ~/.vim/plugins/nerdtree.vim
source ~/.vim/plugins/nord.vim
source ~/.vim/plugins/peekaboo.vim
source ~/.vim/plugins/polyglot.vim
source ~/.vim/plugins/prettier.vim
source ~/.vim/plugins/quick-scope.vim
source ~/.vim/plugins/ranger.vim
source ~/.vim/plugins/sensible.vim
source ~/.vim/plugins/shfmt.vim
source ~/.vim/plugins/snippets.vim
source ~/.vim/plugins/splitjoin.vim
source ~/.vim/plugins/surround.vim
source ~/.vim/plugins/terminal.vim
source ~/.vim/plugins/textobj.vim
source ~/.vim/plugins/tmux.vim
source ~/.vim/plugins/undotree.vim
source ~/.vim/plugins/unimpaired.vim
source ~/.vim/plugins/vimtex.vim
call plug#end()

colorscheme nord

cabbrev lvim
      \ lvim /\<lt><C-R><C-W>\>/gj
      \ *<C-R>=(expand("%:e")=="" ? "" : ".".expand("%:e"))<CR>
      \ <Bar> lw
      \ <C-Left><C-Left><C-Left>

"Consistent downwards/upwards
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

set completeopt=menu,menuone,noinsert,noselect
set complete+=kspell
autocmd FileType context setlocal spell spelllang=en,fr
autocmd FileType gitcommit setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en,fr


"Access man pages
runtime ftplugin/man.vim

"Format shell scripts on save
" let g:shfmt_fmt_on_save = 1

" reselect pasted text
nnoremap gp `[v`]

" change the direction of new splits
set splitbelow
set splitright
