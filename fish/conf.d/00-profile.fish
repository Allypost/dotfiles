if [ -z "$XDG_CONFIG_HOME" ]
    export XDG_CONFIG_HOME="$HOME/.config"
    mkdir -p $XDG_CONFIG_HOME
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

if [ -d "/snap/bin" ]
    set --export PATH "/snap/bin:$PATH"
end
