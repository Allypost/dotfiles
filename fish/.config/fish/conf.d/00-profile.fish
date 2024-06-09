if [ -z "$XDG_CONFIG_HOME" ]
    set --export XDG_CONFIG_HOME "$HOME/.config"
    mkdir -p "$XDG_CONFIG_HOME"
end

if [ -z "$XDG_CACHE_HOME" ]
    set --export XDG_CACHE_HOME "$HOME/.cache"
    mkdir -p "$XDG_CACHE_HOME"
end

if [ -z "$XDG_DATA_HOME" ]
    set --export XDG_DATA_HOME "$HOME/.local/share"
    mkdir -p "$XDG_DATA_HOME"
end

if [ -z "$XDG_STATE_HOME" ]
    set --export XDG_STATE_HOME "$HOME/.local/state"
    mkdir -p "$XDG_STATE_HOME"
end

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]
    set --export PATH "$HOME/bin:$PATH"
end

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]
    set --export PATH "$HOME/.local/bin:$PATH"
end


# Set NPM bin path
set --export NPM_BIN_PATH ''
if [ -d "$HOME/.npm/bin" ]
    set --export NPM_BIN_PATH "$HOME/.npm/bin"
    set --export PATH $PATH "$NPM_BIN_PATH"
end

if [ -d "$HOME/.local/npm/bin" ]
    set --export NPM_BIN_PATH "$HOME/.local/npm/bin"
    set --export PATH $PATH "$NPM_BIN_PATH"
end

if [ ! -z "$NPM_BIN_PATH" ]
    set npm_prefix (dirname $NPM_BIN_PATH)
    command -v npm &>/dev/null && npm config set prefix "$npm_prefix"
end

# set PATH so it includes the user's platform tools (ADB) if it exists
if [ -d "$HOME/.local/platform-tools" ]
    set --export PATH "$HOME/.local/platform-tools:$PATH"
end

# set PATH so it includes user's private scripts if it exists
if [ -d "$HOME/.scripts" ]
    set --export PATH "$HOME/.scripts:$PATH"
end

if [ -d "$HOME/.config/composer/vendor/bin" ]
    set --export PATH $PATH "$HOME/.config/composer/vendor/bin"
end

if [ -d /snap/bin ]
    set --export PATH "/snap/bin:$PATH"
end

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

if [ -d /usr/local/MATLAB/R2021a ]
    set --export PATH $PATH /usr/local/MATLAB/R2021a/bin/
end

if [ -d /var/lib/flatpak/exports/share ]
    set --export PATH $PATH /var/lib/flatpak/exports/share
end

if [ -d "$HOME/.local/share/flatpak/exports/share" ]
    set --export PATH $PATH "$HOME/.local/share/flatpak/exports/share"
end

if [ -f "$HOME/.cargo/env" ]
    set --export PATH "$HOME/.cargo/bin" $PATH
end

if [ -d "$HOME/.cargo/bin" ]
    set --export PATH "$HOME/.cargo/bin" $PATH
end

if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]
    set --export PATH "$HOME/.local/share/JetBrains/Toolbox/scripts" $PATH
end

if [ -d "$HOME/.local/go/bin" ]
    set --export PATH "$HOME/.local/go/bin" $PATH
end

if [ -d /opt/homebrew/bin ]
    set --export PATH $PATH /opt/homebrew/bin/
end

if [ -d "$HOME/.local/surrealdb" ]
    set --export PATH $PATH "$HOME/.local/surrealdb"
end

if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]
    set --export PATH $PATH "$HOME/.local/share/JetBrains/Toolbox/scripts"
end

set --export FLYCTL_INSTALL "$HOME/.local/fly"
if [ -d "$FLYCTL_INSTALL/bin" ]
    set --export PATH "$PATH" "$FLYCTL_INSTALL/bin"
    flyctl completion fish | source
end

if [ -d /opt/nvim-linux64/bin ]
    set --export PATH /opt/nvim-linux64/bin "$PATH"
end

if [ -d "$XDG_DATA_HOME/gem/ruby/3.0.0/bin" ]
    set --export PATH "$PATH" "$XDG_DATA_HOME/gem/ruby/3.0.0/bin"
end

set --global Z_DATA "$HOME/.local/bash/z.db"

set --global TERM xterm-256color

#set --global DOCKER_BUILDKIT 1
#set --global COMPOSE_DOCKER_CLI_BUILD 1

# Colored man pages
set -xU MANPAGER 'less -R --use-color -Dd+r -Du+b'
set -xU MANROFFOPT '-P -c'

# Screen locker config
set --global XSECURELOCK_SHOW_DATETIME 1
# set --global XSECURELOCK_SAVER saver_xscreensaver
set --global SPACEMACSDIR "$XDG_CONFIG_HOME/spacemacs"

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Rust stuff
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

if [ -z "$RIPGREP_CONFIG_PATH" ]
    set --local RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/config"
    if [ -f "$RIPGREP_CONFIG_PATH" ]
        set --global RIPGREP_CONFIG_PATH "$RIPGREP_CONFIG_PATH"
    end
end
