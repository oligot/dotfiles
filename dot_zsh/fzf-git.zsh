# https://polothy.github.io/post/2019-08-19-fzf-git-checkout/
fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(_fzf_git_branches)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'origin/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

# https://waylonwalker.com/nvr-open-files/
fzf-git-worktree() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local worktree

    worktree=$(git worktree list | fzf)
    if [[ "$worktree" = "" ]]; then
      echo "No worktree selected."
      return
    fi

    local dir=$(echo "$worktree" | cut -d ' ' -f1)
    cd "$dir"

    local nvim_listen=~/.cache/nvim/$(basename $(dirname $dir)).pipe
    nvim --server $nvim_listen --remote-send "<C-\><C-N>:cd $dir<CR>"
}
