if [ -d /opt/cuda/bin/ ]
    set --export PATH "$PATH" /opt/cuda/bin
end

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

if [ -d /usr/bin/vendor_perl ]
    fish_add_path --append /usr/bin/vendor_perl
end

if [ -d "$HOME/bin" ]
    fish_add_path --append "$HOME/bin"
end

if [ -d "$HOME/.local/bin" ]
    fish_add_path --prepend "$HOME/.local/bin"
end

set --export NPM_BIN_PATH ''
if [ -d "$HOME/.npm/bin" ]
    set --export NPM_BIN_PATH "$HOME/.npm/bin"
    fish_add_path --prepend "$NPM_BIN_PATH"
end

if [ -d "$HOME/.local/npm/bin" ]
    set --export NPM_BIN_PATH "$HOME/.local/npm/bin"
    fish_add_path --prepend "$NPM_BIN_PATH"
end

if [ ! -z "$NPM_BIN_PATH" ]
    set npm_prefix (dirname $NPM_BIN_PATH)
    command -v npm &>/dev/null && npm config set prefix "$npm_prefix"
end

if [ -d "$HOME/.local/platform-tools" ]
    fish_add_path --prepend "$HOME/.local/platform-tools"
end

if [ -d "$HOME/.scripts" ]
    fish_add_path --prepend "$HOME/.scripts"
end

if [ -d "$HOME/.config/composer/vendor/bin" ]
    fish_add_path --prepend "$HOME/.config/composer/vendor/bin"
end

if [ -d /snap/bin ]
    fish_add_path --prepend /snap/bin
end

if [ -d /usr/local/MATLAB/R2021a ]
    fish_add_path --append /usr/local/MATLAB/R2021a/bin/
end

if [ -d /var/lib/flatpak/exports/share ]
    fish_add_path --prepend /var/lib/flatpak/exports/share
end

if [ -d "$HOME/.local/share/flatpak/exports/share" ]
    fish_add_path --prepend "$HOME/.local/share/flatpak/exports/share"
end

if [ -f "$HOME/.cargo/env.fish" ]
    source "$HOME/.cargo/env.fish"
end

if [ -d "$HOME/.local/go/bin" ]
    fish_add_path --prepend "$HOME/.local/go/bin"
end

if [ -d /opt/homebrew/bin ]
    fish_add_path --prepend /opt/homebrew/bin/
end

if [ -d "$HOME/.local/surrealdb" ]
    fish_add_path --prepend "$HOME/.local/surrealdb"
end

if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]
    fish_add_path --append "$HOME/.local/share/JetBrains/Toolbox/scripts"
end

set --export FLYCTL_INSTALL "$HOME/.local/fly"
if [ -d "$FLYCTL_INSTALL/bin" ]
    fish_add_path --prepend "$FLYCTL_INSTALL/bin"
    flyctl completion fish | source
end

if [ -d /opt/nvim-linux64/bin ]
    fish_add_path --prepend /opt/nvim-linux64/bin
end

if [ -d "$XDG_DATA_HOME/gem/ruby/3.0.0/bin" ]
    set --export PATH "$PATH" "$XDG_DATA_HOME/gem/ruby/3.0.0/bin"
    fish_add_path --append "$XDG_DATA_HOME/gem/ruby/3.0.0/bin"
end

if [ -z "$RIPGREP_CONFIG_PATH" ]
    set --local RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/config"
    if [ -f "$RIPGREP_CONFIG_PATH" ]
        set --global RIPGREP_CONFIG_PATH "$RIPGREP_CONFIG_PATH"
    end
end

if [ -d "$HOME/.local/share/pnpm" ]
    set --export PNPM_HOME "$HOME/.local/share/pnpm"
    fish_add_path --prepend "$PNPM_HOME"
end

if [ -d "$HOME/.rd/bin" ]
    fish_add_path --prepend "$HOME/.rd/bin"
end

if [ -d "$HOME/.turso" ]
    fish_add_path --prepend "$HOME/.turso"
end

if [ -f "$HOME/.local/shared-bin/env/env.fish" ]
    source "$HOME/.local/shared-bin/env/env.fish"
end

if [ -d "$HOME/.opencode/bin" ]
    fish_add_path --prepend "$HOME/.opencode/bin"
end
