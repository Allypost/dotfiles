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

if [ -f '/usr/bin/exa' ]; then
    alias ls="exa "

    alias ll='ls -laF --sort=newest'
    alias la='ls -at --sort=newest'
    alias l='ls -t --sort=newest'
fi

# Allow aliases to trickle thru to sudo
alias sudo='sudo '

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'



# Random git stuff
alias egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias g=git
alias ga='git add'
alias gaa='git add --all'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gamscp='git am --show-current-patch'
alias gap='git apply'
alias gapa='git add --patch'
alias gapt='git apply --3way'
alias gau='git add --update'
alias gav='git add --verbose'
alias gb='git branch'
alias gbD='git branch -D'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*($(git_main_branch)|development|develop|devel|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcam='git commit -a -m'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcf='git config --list'
alias gcl='git clone --recurse-submodules'
alias gclean='git clean -id'
alias gcm='git checkout $(git_main_branch)'
alias gcmsg='git commit -m'
alias gcn!='git commit -v --no-edit --amend'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'
alias gcsm='git commit -s -m'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'
alias gfg='git ls-files | grep'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gitp='git pull --rebase'
alias gk='\gitk --all --branches'
alias gke='\gitk --all $(git log -g --pretty=%h)'
alias gl='git pull'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat -p'
alias glo='git log --oneline --decorate'
alias glod='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'
alias glods='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --all'
alias glols='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --stat'
alias glp=_git_log_prettily
alias glum='git pull upstream $(git_main_branch)'
alias gm='git merge'
alias gma='git merge --abort'
alias gmom='git merge origin/$(git_main_branch)'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpristine='git reset --hard && git clean -dffx'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpu='git push upstream'
alias gpv='git push -v'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase develop'
alias grbi='git rebase -i'
alias grbm='git rebase $(git_main_branch)'
alias grbs='git rebase --skip'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'
alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='git stash --include-untracked'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch -c'
alias gtl='gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'
alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias gupv='git pull --rebase -v'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'



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

if command -v apt-get >/dev/null 2>&1; then
    function apt-update() {
        sudo apt update
        sudo apt upgrade -y
        sudo apt dist-upgrade -y
        sudo apt autoremove -y
        sudo apt autoclean -y
    }

    alias au="apt-update"
    alias apt="sudo apt -y"

    alias update-system="au"
elif command -v yay >/dev/null 2>&1; then
    alias yay='yay --pacman powerpill '

    alias update-system="yay -Syu --devel "
elif command -v pacman >/dev/null 2>&1; then
    alias update-system="pacman -Syu --devel "
fi

alias snap="sudo snap"

alias v="vim"
alias sv="sudo vim"

alias o="xdg-open"

alias kset-proxy="ssh -D 13300 -q -C -N kset"

alias youtube-dl="youtube-dl --http-chunk-size 10M --console-title --prefer-ffmpeg --netrc --add-metadata --ignore-errors"
# alias youtube-dl-best="youtube-dl -f bestvideo+bestaudio --recode-video mp4 --embed-thumbnail --embed-subs --all-subs"
alias youtube-dl-best="youtube-dl -f bestvideo+bestaudio --recode-video mp4 --embed-subs --all-subs"

# alias yt-dl="youtube-dl -f bestaudio --extract-audio --embed-thumbnail --audio-format mp3 --audio-quality 320k -o '%(title)s.%(ext)s'"
alias yt-dl="youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 320k -o '%(title)s.%(ext)s'"
alias y="yt-dl"
# alias meme-dl="youtube-dl -f 'best[width <=? 720][filesize <? 50M]' --id --embed-thumbnail --recode-video mp4"
alias meme-dl="youtube-dl -f 'best[width <=? 720][filesize <? 50M]' --id --recode-video mp4"
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
    if [ -z "$2" ]; then
        $TO_FILE="$(dirname "$1")/$(basename "$1").tar";
    else 
        $TO_FILE="$2";
    fi

    echo "$TO_FILE"

    tar cf - "$1" -P | pv -s $(du -sb "$1" | awk '{print $1}') > "$TO_FILE"
}

function tar-compress() {
    tar cf - "$1" -P | pv -s $(du -sb "$1" | awk '{print $1}') | gzip > "$(dirname "$1")/$(basename "$1").tar.gz"
}

alias watch='watch --color'

function docker-rm-all() {
    docker rm $(docker stop $(docker ps -a -q))
}

# alias start-deezer-downloader='docker run -d --name=Deezldr -v "$HOME/Music/Deezldr:/downloads" -v "$HOME/.config/deezldr:/config" -e PUID=$(id -u) -e PGID=$(id -g) -p 1730:1730 bocki/deezloaderrmx'

alias start-deemix-downloader='docker run --rm -d --name=Deemix  -v "$HOME/Music/Deemix:/downloads"  -v "$HOME/.config/deemix:/config" -e PUID=$(id -u) -e PGID=$(id -g) -p 9666:6595 registry.gitlab.com/bockiii/deemix-docker && docker logs -f Deemix'

alias serve-current-directory='python3 -m http.server'

function mpv-stream() {
    mpv `youtube-dl -f best -g -q "$1"`
}

function fix-opensubtitles-encoding() {
    [ -z "$1" ] && echo "You must provide a file path" && return 1
    TEMP_FILE="$(mktemp)"
    iconv -f CP1252 -t UTF-8//TRANSLIT "$1" -o "$TEMP_FILE"
    sed -rEi 's/æ/ć/gi' "$TEMP_FILE"
    sed -rEi 's/è/č/gi' "$TEMP_FILE"
    sed -rEi 's/ð/đ/gi' "$TEMP_FILE"
    sed -rEi 's/\. ([šđčćž])/. \u\1/g' "$TEMP_FILE"
    kioclient5 move "$1" trash:/ 2>/dev/null
    mv "$TEMP_FILE" "$1"
}

#alias ssh-kset="ssh -J $USER@cortana.kset.org"
function ssh-kset() {
    ssh -J "$USER@cortana.kset.org" "$USER@$1"
}


alias power-down="update-system && shutdown -h now"
alias go-away-computer="power-down"

alias emacs-tui="emacs -nw"

function adb-wait-for-device() {
    adb wait-for-device && notify-send -u critical -a 'ADB' --icon 'phone' 'Phone connected' "The device '`adb shell getprop ro.product.model`' has connected to the computer"
}

alias a2cdl="aria2c -x 16 "

alias png-compress="pngquant --skip-if-larger --ext .png --force --speed 1 --strip "
