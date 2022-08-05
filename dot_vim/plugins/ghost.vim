Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

function! s:SetupGhostBuffer()
    if match(expand("%:a"), '\v/ghost-jira')
        set ft=confluence
    endif
endfunction

augroup vim-ghost
    au!
    au User vim-ghost#connected call s:SetupGhostBuffer()
augroup END
