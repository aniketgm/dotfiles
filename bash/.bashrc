#              __________________ 
#          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
#         /  \  \  \         __/  /  \  /  \          Description : Bashrc configuration. Highlights:
#        /    \  \       _____   /    \/    \                       > Firefox as default browser
#       /  /\  \  \     /    /  /            \                      > AutoCD to directories
#      /        \  \        /  /      \/      \                     > Zoxide for directory hopping
#     /          \  \      /  /                \                    > Starship prompt
#    /            \  \    /  /                  \                   > Tmux as default terminal session
#   /              \  \  /  /                    \
#  /__            __\  \/  /__                  __\   Github Repo : https://github.com/aniketgm/Dotfiles
#

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Add $HOME/bin and $HOME/.local/bin to PATH
# [[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"               | Commented out since already defined in .profile.
# [[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH" | For new machine setup check profile/PATH if not included.

# Define xdg config home 
[[ -z "${XDG_CONFIG_HOME}" ]] && export XDG_CONFIG_HOME="$HOME/.config"

# Set EDITOR to lvim
[[ -z "${EDITOR}" ]] && export EDITOR="lvim"

# Define browser variable
[ -x /usr/bin/firefox ] && export BROWSER="/usr/bin/firefox"

# Check if Windows access is enabled and set a var for it.
[[ -d "/mnt/c/Users/Aniket" ]] && WIN_HOME="/mnt/c/Users/Aniket"
[[ -d "/mnt/d/SummuData" ]] && WIN_D_DRIVE="/mnt/d/SummuData"

shopt -s checkwinsize # Check the window size after each command, if necessary, update the values of LINES and COLUMNS.
shopt -s histappend   # When the shell exits, append to the history file instead of overwriting it. 
shopt -s autocd       # When a fodler is specified at commandline, cd into it automatically.
#shopt -s globstar

HISTCONTROL=ignoreboth:erasedups # Ignore both -- commands starting with space and duplicates and erase duplicates.
HISTSIZE=10000                   # Number of lines of history.
HISTFILESIZE=20000               # History file size in bytes.

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
# Export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Use exa, modern replacement for ls. [https://github.com/ogham/exa]
if [ -x /usr/bin/exa ]; then
    alias l='exa -F --icons'
    alias ll='exa -alF --group-directories-first --icons'
    alias la='exa -aF --group-directories-first --icons'
    alias lse='exa -alF -s extension --group-directories-first --icons'
    alias lss='exa -alF -s size --group-directories-first --icons'
    alias lst='exa -aF -s type --group-directories-first --icons'
    alias lsm='exa -alF -s modified --group-directories-first --icons'
    alias ltr='exa -alF --tree --level=1 --group-directories-first --icons'
    alias ltr2='exa -alF --tree --level=2 --group-directories-first --icons'
fi

# Set fzf default options for preview
[ -x /usr/bin/fzf ] &&
    export FZF_DEFAULT_OPTS="--bind shift-up:preview-half-page-up,shift-down:preview-half-page-down --history=$HOME/.fzf_history"

# Set batcat default options for preview
if [ -x /usr/bin/batcat ]; then
    export BAT_THEME="Monokai Extended Bright"
    export BAT_STYLE="numbers,changes,header"
    export BAT_PAGER="less -RF"
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Store other aliases in .bash_aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Store custom functions in .bash_functions file
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Golang exports
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Set greeting colors / message: using colorscript (DistroTube) OR fortune OR neofetch
if type colorscript &>/dev/null; then
    colorscript random
elif type fortune &>/dev/null && type cowsay &>/dev/null && type lolcat &>/dev/null; then
    fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) | lolcat
elif type neofetch &>/dev/null; then
    neofetch
else
    echo ""
    echo " The journey of a thousand miles begins with one step."
    echo "                                                 - Lao Tzu"
    echo ""
    echo "Seems non of colorscript by [DistroTube] OR fortune OR neofetch is installed."
    echo "Note you will be getting this same quote everytime bash prompt is launched."
    echo "Also, Run the script in ~/bin folder to install the missing softwares, if not already."
fi

# TimeWarrior env var
# export TIMEWARRIORDB="$HOME/.config/task/.timewarrior"

# Jump shell
# eval "$(jump shell)"

# Zoxide shell (similar to Jump)
# if command -v zoxide &>/dev/null; then
#   eval "$(~/.local/bin/zoxide init bash)"
# fi
eval "$(~/.local/bin/zoxide init bash)"

# Starship Prompt
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi

