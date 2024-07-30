if command -v mise &>/dev/null
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
    end

    mise completion fish | source
    alias rtx=mise
else if command -v rtx &>/dev/null
    rtx activate fish | source
    set completions_file "$__fish_config_dir/completions/rtx.fish"
    if ! [ -f "$completions_file" ]
        rtx complete -s fish >"$completions_file"
        fish_update_completions
    end
else if [ -f "$HOME/.asdf/asdf.fish" ]
    source ~/.asdf/asdf.fish
end

if command -v sccache &>/dev/null
    set --global RUSTC_WRAPPER sccache
end

if command -v zoxide &>/dev/null
    zoxide init fish | source
end

if command -v atuin &>/dev/null
    atuin init fish --disable-up-arrow | source
    atuin gen-completions --shell fish | source
end

if command -v tailscale &>/dev/null
    tailscale completion fish | source
end

if command -v kind &>/dev/null
    kind completion fish | source
end
