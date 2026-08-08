setopt extendedglob globstarshort

p() {
    local root="$HOME/projects"
    local repo

    repo=$(print -rl "$root"/**/.git(N:h) 2>/dev/null | fzf)
    [ -n "$repo" ] && cd "$repo"
}

c() {
    local root="$HOME/.config"
    local dir
    local files

    dir=$(print -rl "$root"/*(/N) "$root"/*(@N) | fzf | head -n1) || return

    [ -z "$dir" ] && return

    cd "$dir" || return

    files=(*(.N))   # regular files in current directory
    if [ "${#files[@]}" -eq 1 ]; then
        nvim "${files[1]}"
    else
        nvim
    fi
}
