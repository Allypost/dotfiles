# some more ls aliases
alias ll='ls -Alhtr'
alias lS='ll -S'
alias la='ls -At'
alias l='ls -Ct'

set _exa_cmd (command -v eza || command -v exa)
if [ ! -z "$_exa_cmd" ]
    alias ls="$_exa_cmd"

    alias ll='ls -laF --sort=newest'
    alias la='ls -at --sort=newest'
    alias l='ls -t --sort=newest'
end

alias md='mkdir -p'
# alias cd..='cd ..'
# alias ..='cd ..'

# Allow aliases to trickle thru to sudo
# alias sudo='sudo '

function rand-string -d "Generate random string"
    set --function DEFAULT_LENGTH 32
    set --function LENGTH $DEFAULT_LENGTH
    set -q argv[1]; and set --function LENGTH $argv[1]

    LC_ALL=C tr -dc A-Za-z0-9 </dev/urandom | head -c "$LENGTH"
end

function weather
    curl "https://wttr.in/Maksimir?FAQ"
end
alias wttr='weather'

# Random git stuff
alias g=git
alias ga='git add'
# alias gaa='git add --all'
# alias gam='git am'
# alias gama='git am --abort'
# alias gamc='git am --continue'
# alias gams='git am --skip'
# alias gamscp='git am --show-current-patch'
# alias gap='git apply'
# alias gapa='git add --patch'
# alias gapt='git apply --3way'
# alias gau='git add --update'
# alias gav='git add --verbose'
# alias gb='git branch'
# alias gbD='git branch -D'
# alias gba='git branch -a'
# alias gbd='git branch -d'
# alias gbl='git blame -b -w'
# alias gbnm='git branch --no-merged'
# alias gbr='git branch --remote'
# alias gbs='git bisect'
# alias gbsb='git bisect bad'
# alias gbsg='git bisect good'
# alias gbsr='git bisect reset'
# alias gbss='git bisect start'
# alias gc='git commit -v'
# alias gc!='git commit -v --amend'
# alias gca='git commit -v -a'
# alias gca!='git commit -v -a --amend'
# alias gcam='git commit -a -m'
# alias gcan!='git commit -v -a --no-edit --amend'
# alias gcans!='git commit -v -a -s --no-edit --amend'
# alias gcb='git checkout -b'
# alias gcd='git checkout develop'
# alias gcf='git config --list'
# alias gcl='git clone --recurse-submodules'
# alias gclean='git clean -id'
alias gcmsg='git commit -m'
# alias gcn!='git commit -v --no-edit --amend'
alias gco='git checkout'
# alias gcount='git shortlog -sn'
# alias gcp='git cherry-pick'
# alias gcpa='git cherry-pick --abort'
# alias gcpc='git cherry-pick --continue'
# alias gcs='git commit -S'
# alias gcsm='git commit -s -m'
# alias gd='git diff'
# alias gdca='git diff --cached'
# alias gdcw='git diff --cached --word-diff'
# alias gds='git diff --staged'
# alias gdt='git diff-tree --no-commit-id --name-only -r'
# alias gdw='git diff --word-diff'
alias gf='git fetch'
# alias gfa='git fetch --all --prune --jobs=10'
# alias gfg='git ls-files | grep'
# alias gfo='git fetch origin'
# alias gg='git gui citool'
# alias gga='git gui citool --amend'
# alias ggpur=ggu
# alias ghh='git help'
# alias gignore='git update-index --assume-unchanged'
# alias gignored='git ls-files -v | grep "^[[:lower:]]"'
# alias gitp='git pull --rebase'
# alias gk='\gitk --all --branches'
alias gl='git pull'
# alias glg='git log --stat'
# alias glgg='git log --graph'
# alias glgga='git log --graph --decorate --all'
# alias glgm='git log --graph --max-count=10'
# alias glgp='git log --stat -p'
# alias glo='git log --oneline --decorate'
# alias glp=_git_log_prettily
# alias gm='git merge'
# alias gma='git merge --abort'
# alias gmt='git mergetool --no-prompt'
# alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
# alias go-away-computer=power-down
alias gp='git push'
# alias gpd='git push --dry-run'
# alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
# alias gpoat='git push origin --all && git push origin --tags'
# alias gpristine='git reset --hard && git clean -dffx'
# alias gpu='git push upstream'
# alias gpv='git push -v'
# alias gr='git remote'
# alias gra='git remote add'
# alias grb='git rebase'
# alias grba='git rebase --abort'
# alias grbc='git rebase --continue'
# alias grbd='git rebase develop'
# alias grbi='git rebase -i'
# alias grbs='git rebase --skip'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
# alias grev='git revert'
# alias grh='git reset'
# alias grhh='git reset --hard'
alias grm='git rm'
alias grmc='git rm --cached'
# alias grmv='git remote rename'
# alias grrm='git remote remove'
# alias grs='git restore'
# alias grset='git remote set-url'
# alias grss='git restore --source'
# alias grst='git restore --staged'
# alias gru='git reset --'
# alias grup='git remote update'
# alias grv='git remote -v'
# alias gsb='git status -sb'
# alias gsd='git svn dcommit'
# alias gsh='git show'
# alias gsi='git submodule init'
# alias gsps='git show --pretty=short --show-signature'
# alias gsr='git svn rebase'
# alias gss='git status -s'
alias gst='git status'
# alias gsta='git stash push'
# alias gstaa='git stash apply'
# alias gstall='git stash --all'
# alias gstc='git stash clear'
# alias gstd='git stash drop'
# alias gstl='git stash list'
# alias gstp='git stash pop'
# alias gsts='git stash show --text'
# alias gstu='git stash --include-untracked'
# alias gsu='git submodule update'
# alias gsw='git switch'
# alias gswc='git switch -c'
# alias gts='git tag -s'
# alias gtv='git tag | sort -V'
# alias gunignore='git update-index --no-assume-unchanged'
# alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
# alias gup='git pull --rebase'
# alias gupa='git pull --rebase --autostash'
# alias gupav='git pull --rebase --autostash -v'
# alias gupv='git pull --rebase -v'
# alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'


if command -v apt-get >/dev/null 2>&1
    function apt-update
        set --local debian_frontend_old "$DEBIAN_FRONTEND"
        set --global DEBIAN_FRONTEND noninteractive
        sudo apt update
        sudo apt upgrade -y
        sudo apt dist-upgrade -y
        sudo apt autoremove -y
        sudo apt autoclean -y
        set --global DEBIAN_FRONTEND "$debian_frontend_old"
    end

    alias au="apt-update"
    alias apt="sudo apt -y"

    alias update-system="au"
else if command -v yay >/dev/null 2>&1
    # alias yay='yay '

    alias update-system="yay -Syu --devel"
else if command -v pacman >/dev/null 2>&1
    alias update-system="pacman -Syu --devel"
end

alias snap="sudo snap"

alias v="nvim"
alias sv="doas nvim"

alias o="xdg-open"

# alias youtube-dl="youtube-dl --cookies-from-browser chrome --concurrent-fragments 8 --console-title --prefer-ffmpeg --netrc --add-metadata --ignore-errors"
# # alias youtube-dl-best="youtube-dl -f bestvideo+bestaudio --recode-video mp4 --embed-thumbnail --embed-subs --all-subs"
# alias youtube-dl-best="youtube-dl -f bestvideo+bestaudio --recode-video mp4 --embed-subs --all-subs"
#
# # alias yt-dl="youtube-dl -f bestaudio --extract-audio --embed-thumbnail --audio-format mp3 --audio-quality 320k -o '%(title)s.%(ext)s'"
# alias yt-dl="youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 320k -o '%(title)s.%(ext)s'"
# alias y="yt-dl"
# # alias meme-dl="youtube-dl -f 'best[width <=? 720][filesize <? 50M]' --id --embed-thumbnail --recode-video mp4"
# alias meme-dl="youtube-dl -f 'best[width <=? 720][filesize <? 50M]' --id --recode-video mp4"
# alias m="meme-dl"

# alias gitp="git pull --rebase"

alias clip="xclip -sel clip"

alias cls='printf "\033[2J\033[3J\033[1;1H"'

alias cdtemp='cd "$(mktemp -d)"'

# alias rm='rm -i'

# alias gitp='git pull --rebase'
# alias top='s-tui'
# alias stop='sudo s-tui'

function swap-clear
    # Dirty hack to request sudo
    # for a prettier printing experience
    sudo cat /dev/null

    printf "Clearing... "
    sudo swapoff -a && sudo swapon -a
    printf "\r"
    echo "Cleared swap"
end

alias watch='watch --color'

alias power-down="update-system && shutdown -h now"
alias go-away-computer="power-down"

function adb-wait-for-device
    set MODEL (adb shell getprop ro.product.model)
    adb wait-for-device && notify-send -u critical -a ADB --icon phone 'Phone connected' "The device '$MODEL' has connected to the computer"
end

alias a2cdl="aria2c -x 16 --seed-time 0"

alias png-compress="pngquant --skip-if-larger --ext .png --force --speed 1 --strip"

function optimize-pdf
    set input_file $argv[1]
    set output_file $argv[2]

    gs \
        -sDEVICE=pdfwrite \
        -dPDFSETTINGS=/printer \
        -dCompatibilityLevel=1.4 \
        -r75 \
        -dNOPAUSE \
        -dQUIET \
        -dBATCH \
        -sOutputFile="$output_file" \
        "$input_file"
end
