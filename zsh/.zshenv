#
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░
#
# shamelessly stolen from xero

# preferred text editor
export EDITOR=emacs
export VISUAL=emacs

# language
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LESSCHARSET=utf-8

export GOPATH="/home/phat_sumo/.go"
export GOMODPATH="/home/phat_sumo/.go/pkg/mod"

export TERM="xterm-256color"
export WINEPREFIX="/home/phat_sumo/.wine"

#export QT_QPA_PLATFORMTHEME=qt5ct

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*) machine=Linux ;;
    Darwin*) machine=Mac ;;
    CYGWIN*) machine=Cygwin ;;
    MINGW*) machine=MinGw ;;
    OpenBSD*) machine=OpenBSD ;;
    *) machine="UNKNOWN:${unameOut}" ;;
esac

if [ -f /etc/os-release ]; then
    source /etc/os-release
fi

if [[ $NAME =~ "Ubuntu" ]]; then
    # ubuntu version doesn't support --border=sharp
    export FZF_DEFAULT_OPTS='
    --color=bg:#000300,fg:#fbf5f3,bg+:#000300,fg+:#fbf5f3
    --color=info:#00fbc3,spinner:#00fbc3,hl:#00fbc3,hl+:#fe3198,pointer:#fe3198
    --color=prompt:#00fbc3,marker:#fe3198,header:#0fd7ff,border:#fe3198
  '
else
    export FZF_DEFAULT_OPTS='
    --color=bg:#000300,fg:#fbf5f3,bg+:#000300,fg+:#fbf5f3
    --color=info:#00fbc3,spinner:#00fbc3,hl:#00fbc3,hl+:#fe3198,pointer:#fe3198
    --color=prompt:#00fbc3,marker:#fe3198,header:#0fd7ff,border:#fe3198
    --border=sharp
  '
fi

export FZF_CTRL_R_OPTS=+s

export OS=$machine

autoload -Uz zmv

export N_PREFIX=$HOME/.n

export PLAYDATE_SDK_PATH=/home/phat_sumo/.local/share/playdate-sdk-2.1.1

export MOZ_USE_XINPUT2=1

# paths
export PATH=/usr/local/bin:/usr/games:$HOME/bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/src/go/bin/:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/.npm/bin:$N_PREFIX/bin:$HOME/.ghcup/bin:$PLAYDATE_SDK_PATH/bin:$PATH
