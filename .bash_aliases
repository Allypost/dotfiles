# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -Alhtr'
alias lS='ll -S'
alias la='ls -At'
alias l='ls -Ct'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

function extract() {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f "$1" ] ; then
            NAME="$(basename "$1")"
            # If name has extension, remove it
            if [[ "$NAME" =~ ^[^.]+ ]]; then
                NAME="$(echo "$NAME" | sed 's/\.[^.]*$//')"
            fi
            mkdir "$NAME" && cd "$NAME" && cp "../$1" "./"
            case $1 in
                *.tar.bz2)  tar xvjf     "$1" ;;
                *.tar.gz)   tar xvzf     "$1" ;;
                *.tar.xz)   tar xvJf     "$1" ;;
                *.lzma)     unlzma       "$1" ;;
                *.bz2)      bunzip2      "$1" ;;
                *.rar)      unrar x -ad  "$1" ;;
                *.gz)       gunzip       "$1" ;;
                *.tar)      tar xvf      "$1" ;;
                *.tbz2)     tar xvjf     "$1" ;;
                *.tgz)      tar xvzf     "$1" ;;
                *.zip)      unzip        "$1" ;;
                *.Z)        uncompress   "$1" ;;
                *.7z)       7z x         "$1" ;;
                *.xz)       unxz         "$1" ;;
                *.exe)      cabextract   "$1" ;;
                *)          echo "extract: '$1' - unknown archive method" ;;
            esac
            rm "$1"
            cd ..
        else
            echo "$1 - file does not exist"
        fi
    fi
}

alias rand-string="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1"

function php-run() {
    PROG_ARGS=()
    ARGS=()
    name="php-$(rand-string)"
    
    while test $# -gt 0; do
        case "$1" in
            -p|--port)
                shift
                ARGS+=("-p")
                ARGS+=("$1:$1")
                shift
                ;;
            *)
                PROG_ARGS+=("$1")
                shift
                continue
                ;;
        esac
    done
    
    docker run -it --rm --name "$name" -v "$PWD":/usr/src/myapp -w /usr/src/myapp "${ARGS[@]}" php:cli php "${PROG_ARGS[@]}"
}

function composer-run() {
    docker run --rm --interactive --tty --volume $PWD:/app --volume ${COMPOSER_HOME:-$HOME/.composer}:/tmp composer "$@"
}

function weather() {
    curl "https://wttr.in/${1-~Maksimir?FAQ}"
}
alias wttr='weather'

function apt-update() {
    sudo apt update;
    sudo apt upgrade -y;
    sudo apt dist-upgrade -y;
    sudo apt autoremove -y;
    sudo apt autoclean -y;
}
alias au="apt-update"
alias apt="sudo apt -y"

alias snap="sudo snap"

alias v="vim"
alias sv="sudo vim"

alias o="xdg-open"

alias kset-proxy="ssh -D 13300 -q -C -N kset"

alias youtube-dl="youtube-dl --http-chunk-size 10M --console-title --prefer-ffmpeg --netrc --add-metadata --ignore-errors"
alias youtube-dl-best="youtube-dl -f bestvideo+bestaudio --recode-video mp4 --embed-thumbnail --embed-subs --all-subs"

alias yt-dl="youtube-dl -f bestaudio --extract-audio --embed-thumbnail --audio-format mp3 --audio-quality 320k -o '%(title)s.%(ext)s'"
alias y="yt-dl"
alias meme-dl="youtube-dl -f 'best[width <=? 720][filesize <? 50M]' --id --embed-thumbnail --recode-video mp4"
alias m="meme-dl"

alias gitp="git pull --rebase"

alias clip="xclip -sel clip"

alias cls='printf "\033[2J\033[3J\033[1;1H"'

function please() {
    if [ $# -eq 0 ]; then
        sudo $(history -p \!\!)
    else
        sudo $@
    fi
}
alias pls='please'

function shrug() {
    printf "¯\\_(ツ)_/¯"
}

function lenny() {
    printf "( ͡° ͜ʖ ͡°)"
}

alias cdtemp='cd `mktemp -d`'

alias va='v ~/.bash_aliases && source ~/.bash_aliases'

alias rm='rm -i'

alias gitp='git pull --rebase'
alias top='s-tui'
alias stop='sudo s-tui'

function swap-clear() {
    # Dirty hack to request sudo
    # for a prettier printing experience
    sudo cat /dev/null
    
    printf "Clearing... "
    sudo swapoff -a && \
    sudo  swapon -a
    printf "\r"
    echo   "Cleared swap"
}

function switch-to-test-env() {
    eval $(make -s env-test)
}

function make-test-env-reduced() {
    switch-to-test-env
    make up
    docker/cli bin/console prepare:elastic
}

function make-test-env() {
    switch-to-test-env
    make init-reduced
    docker/cli bin/console prepare:elastic
}

alias pt='docker/cli vendor/bin/phpunit' 
alias ptd='docker/cli php-debug vendor/bin/phpunit'

function tar-store() {
    tar cf - "$1" -P | pv -s $(du -sb "$1" | awk '{print $1}') > "$(dirname "$1")/$(basename "$1").tar"
}

function tar-compress() {
    tar cf - "$1" -P | pv -s $(du -sb "$1" | awk '{print $1}') | gzip > "$(dirname "$1")/$(basename "$1").tar.gz"
}

alias watch='watch --color'

function docker-rm-all() {
    docker rm $(docker stop $(docker ps -a -q))
}

alias start-deezer-downloader='docker run -d --name=Deezldr -v "$HOME/Music/Deezldr:/downloads" -v "$HOME/.config/deezldr:/config" -e PUID=$(id -u) -e PGID=$(id -g) -p 1730:1730 bocki/deezloaderrmx'

alias serve-current-directory='python3 -m http.server'

function compact-video() {
    filename="${1##*/}"                             # Strip longest match of */ from start
    base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
    ext="${filename:${#base} + 1}"                  # Substring from len of base thru end
    if [[ -z "$base" && -n "$ext" ]]; then          # If we have an extension and no base, it's really the base
        base=".$ext"
        ext=""
    fi

    ffmpeg -i "$1" -c:v libx265 -crf 30 -b:a 320k -deadline best -vf "scale=-2:480" -map_metadata -1 "$(dirname "$1")/$base.s.$ext"
}
alias cv='compact-video'

