bind \cl 'clear; commandline -f repaint'

if ! command -v atuin >/dev/null 2>&1
    bind \cr peco-select-history
end
