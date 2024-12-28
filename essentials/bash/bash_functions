#              __________________ 
#          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
#         /  \  \  \         __/  /  \  /  \          Description : Bash functions configuration.
#        /    \  \       _____   /    \/    \
#       /  /\  \  \     /    /  /            \        Github Repo : https://github.com/aniketgm/dotfiles
#      /        \  \        /  /      \/      \
#     /          \  \      /  /                \
#    /            \  \    /  /                  \
#   /              \  \  /  /                    \
#  /__            __\  \/  /__                  __\
#

# Fuzzy search aliases
fa() {
    alias | fzf --height=20 --reverse
}

# Fuzzy search command history
fh() {
    history | fzf --height=20 --reverse
}

# Fuzzy file finder customized to open with lunarvim.
ffe() {
    if ! command -v rg &>/dev/null; then
        echo "rg is not installed"
        return 0
    fi
    [[ ! -z "$1" ]] && ARG1=$1 || ARG1=.
    FZF_OUTPUT=$(rg --files --hidden --ignore-case $ARG1 | \
                 fzf --preview="batcat --color=always --style=numbers {}" \
                     --height=20 --reverse)
    [[ ! -z $FZF_OUTPUT ]] && lvim $FZF_OUTPUT
}

ffo() {
    if ! command -v xdg-open &>/dev/null; then
        echo "xdg-open is not installed"
        return 0
    fi
    FZF_OUTPUT=$(rg --files --ignore-case --no-messages | fzf --height=20 --reverse)
    [[ ! -z $FZF_OUTPUT ]] && xdg-open $FZF_OUTPUT
}

# Fuzzy folder switcher
fdd() {
    if ! command -v fdfind &>/dev/null; then
        FIND_CMD="fdfind . -t d"
    else
        FIND_CMD="find . -type d"
    fi
    FZF_OUTPUT=$($FIND_CMD | \
                 fzf --preview="ls -l --color=always --group-directories-first {}" \
                     --height=20 --reverse)
    [[ ! -z $FZF_OUTPUT ]] && cd $FZF_OUTPUT
}

# Git status of current branch with FZF
fgs() {
    git status --porcelain | \
    fzf --header="Status with diffs" \
        --preview="git diff {2} | delta -s --width=$(tput cols)" \
        --reverse --preview-window down:70%
}

# Git commits of current branch with FZF
fgc() {
    if ! command -v git &>/dev/null; then
        echo "git is not installed"
        return 0
    fi
    git log --pretty=format:"%h %ar %s" | \
    fzf --header="Branch commits with diffs" \
        --preview "git show {1} | delta -s --width=$(tput cols)" \
        --reverse --preview-window down:70%
}

mcd() {
    [[ ! -z "$1" ]] && mkdir -pv $1 && cd $1
}

# Taskwarrior daily burndown chart on loop
twb() {
    if ! command -v task &>/dev/null; then
        echo "taskwarrior not installed"
    else
        while true
        do
            clear
            task burndown.daily
            sleep 5
        done
    fi
}

sv() {
    case "$1" in
        l)
            sudo service --status-all
            # sudo systemctl
            ;;
        u)
            sudo service $2 start
            # sudo systemctl start $1
            ;;
        d)
            sudo service $2 stop
            # sudo systemctl stop $1
            ;;
        s)
            sudo service $2 status
            # sudo systemctl status $1
            ;;
        *)
            echo "Usage: sv option <service>. Options: s (status) OR u (start) OR d (stop) OR l (list)"
            ;;
    esac
}
# Go into the directory specified by $1 and run the command specified by $2
# run_cmd() {
#     if [ ! -z "$1" ] && [ ! -z "$2" ]; then
#         ARG1=$1
#         ARG2=$2
#     else
#         echo "Argument missing"
#     fi
#     CURR_DIR=$PWD
#     cd $ARG1
#     $ARG2
#     cd $CURR_DIR
# }

# Startup Zinrelo docker containers
# dkc() {
#     case "$1" in
#         u)
#             run_cmd "/home/aniketgm/codebase/src/zrldockerconf" "docker-compose up -d"
#             allContnrs=("zinrelodevapp_web_1" "zinrelodevapp_mongo_1" "zinrelodevapp_mongo-sec_1" "zinrelodevapp_mongo-arb_1" \
#                         "zinrelodevapp_monstache_1" "zinrelodevapp_celery_1" "zinrelodevapp_redis_1" "zinrelodevapp_elasticsearch_1")
#             for contr in ${allContnrs[@]}; do
#                 if ! [[ $(docker ps --format "table {{.Names}}" | grep $contr) ]]; then
#                     echo -e "\e[38;5;197mError: $contr is not running !!\e[0m"
#                 fi
#             done
#             ;;
#         d)
#             run_cmd "/home/aniketgm/codebase/src/zrldockerconf" "docker-compose down"
#             ;;
#         r)
#             run_cmd "/home/aniketgm/codebase/src/zrldockerconf" "docker-compose restart"
#             allContnrs=("zinrelodevapp_web_1" "zinrelodevapp_mongo_1" "zinrelodevapp_mongo-sec_1" "zinrelodevapp_mongo-arb_1" \
#                         "zinrelodevapp_monstache_1" "zinrelodevapp_celery_1" "zinrelodevapp_redis_1" "zinrelodevapp_elasticsearch_1")
#             for contr in ${allContnrs[@]}; do
#                 if ! [[ $(docker ps --format "table {{.Names}}" | grep $contr) ]]; then
#                     echo -e "\e[38;5;197mError: $contr is not running !!\e[0m"
#                 fi
#             done
#             ;;
#         *)
#             echo "Pass valid options. u (mean up) or d (means down) or r (means restart)"
#             ;;
#     esac
# }

#TODO: Add a specialized cp function that can create directories if DEST directories don't exist
