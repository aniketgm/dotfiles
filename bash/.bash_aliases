#              __________________ 
#          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
#         /  \  \  \         __/  /  \  /  \          Description : Bash aliases configuration.
#        /    \  \       _____   /    \/    \
#       /  /\  \  \     /    /  /            \        Github Repo : https://github.com/aniketgm/Dotfiles
#      /        \  \        /  /      \/      \
#     /          \  \      /  /                \
#    /            \  \    /  /                  \
#   /              \  \  /  /                    \
#  /__            __\  \/  /__                  __\
#

# Move, Copy, Delete with verboses
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# Git
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gdt='git difftool --dir-diff'
alias gpl='git pull'
alias gps='git push'
alias gs='git status'

# Docker
alias dcd='docker-compose down'
alias dcp='docker-compose'
alias dcu='docker-compose up'
alias dk='docker'
alias dka='docker ps --format "table {{ .ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}" -a && echo '' && docker images && echo '' && docker volume ls'
alias dkc='docker ps --format "table {{ .ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dkca='docker ps --format "table {{ .ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}" -a'
alias dke='docker exec -it'
alias dki='docker images'
alias dkl='docker logs'
alias dkr='docker rm'
alias dkv='docker volume ls'
# alias dkwp='docker exec -it zinrelodevapp_web_1 /bin/bash'
# alias dkwl='docker logs zinrelodevapp_web_1 --follow'

# Other aliases
alias asq='asciiquarium'
alias b='batcat'
alias bt='btop'
alias c='z'
alias cls='clear'
alias dt='date "+[%a %d, %b %Y] %H:%M"'
alias dum1='du -h --max-depth=1'
alias ecs='emacs -fs &'
alias etree='exa --tree'
alias fd='fdfind'
alias irc='irssi'
alias lg='lazygit'
alias matx='cmatrix'
alias md='mkdir -vp'
alias ns='npm start'
alias nvc='lvim ~/.config/lvim/config.lua'
alias o='xdg-open'
alias pf='pip freeze'
alias py='python'
alias q='exit'
alias rmr='rm -rfv'
alias sai='sudo apt install'
alias sau='sudo apt update'
alias sb='source ~/.bashrc'
alias so='source'
alias ssi='sudo snap install'
alias tk='task'
alias tkt='taskwarrior-tui'
alias tm='tmux -u'
alias tmc='lvim ~/.config/tmux/tmux.conf'
alias v='lvim'
alias va='lvim ~/.bash_aliases'
alias vac='lvim ~/.config/alacritty/alacritty.yml'
alias vb='lvim ~/.bashrc'
alias vd='lvim -d'
alias vf='lvim ~/.bash_functions'
alias vimdiff='lvim -d'
alias vn='cd ~/Documents/Telekasten && lvim'
alias vs='lvim ~/.config/starship.toml'
