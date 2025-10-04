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

if [ -d "$HOME/bin" ]
    set --export PATH "$HOME/bin:$PATH"
end

if [ -d "$HOME/.local/bin" ]
    set --export PATH "$HOME/.local/bin:$PATH"
end

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

if [ -d "$HOME/.local/platform-tools" ]
    set --export PATH "$HOME/.local/platform-tools:$PATH"
end

if [ -d "$HOME/.scripts" ]
    set --export PATH "$HOME/.scripts:$PATH"
end

if [ -d "$HOME/.config/composer/vendor/bin" ]
    set --export PATH $PATH "$HOME/.config/composer/vendor/bin"
end

if [ -d /snap/bin ]
    set --export PATH "/snap/bin:$PATH"
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

if [ -f "$HOME/.cargo/env.fish" ]
    source "$HOME/.cargo/env.fish"
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

if [ -z "$RIPGREP_CONFIG_PATH" ]
    set --local RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/config"
    if [ -f "$RIPGREP_CONFIG_PATH" ]
        set --global RIPGREP_CONFIG_PATH "$RIPGREP_CONFIG_PATH"
    end
end

if [ -d "$HOME/.local/share/pnpm" ]
    set --export PNPM_HOME "$HOME/.local/share/pnpm"
    set --export PATH "$PNPM_HOME" "$PATH"
end

if [ -d "$HOME/.rd/bin" ]
    set --export PATH "$PATH" "$HOME/.rd/bin"
end

if [ -d "$HOME/.turso" ]
    set --export PATH "$HOME/.turso" "$PATH"
end

if [ -f "$HOME/.local/shared-bin/env/env.fish" ]
    source "$HOME/.local/shared-bin/env/env.fish"
end
