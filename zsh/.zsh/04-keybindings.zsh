#                 ██      
#                ░██      
#  ██████  ██████░██      
# ░░░░██  ██░░░░ ░██████  
#    ██  ░░█████ ░██░░░██ 
#   ██    ░░░░░██░██  ░██ 
#  ██████ ██████ ░██  ░██ 
# ░░░░░░ ░░░░░░  ░░   ░░  
#
# shamelessly stolen from xero
#
# keybindings
#typeset -A key

# vi mode, with .1s timeout, proper backspace
bindkey -v 
export KEYTIMEOUT=0
bindkey "^?" backward-delete-char


setopt auto_cd

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "^[^[" sudo-command-line
bindkey -M vicmd "^[^[" sudo-command-line

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle -R; zle reset-prompt }
}

zle -N zle-keymap-select
zle -N edit-command-line


bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-r to perform backward search in history
bindkey '^r' history-incremental-search-backward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  #MODE_INDICATOR="%{$fg_bold[magenta]%}<%{$fg[magenta]%}<<%{$reset_color%}"
  MODE_INDICATOR="%F{magenta}<<"
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    #EXIT_CODE_PROMPT+="%{$fg[magenta]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[magenta]%}$LAST_EXIT_CODE%{$reset_color%}"
    #EXIT_CODE_PROMPT+="%{$fg[magenta]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(check_last_exit_code) $(vi_mode_prompt_info)'
fi

if [[ $OS =~ "Mac" ]]; then
  source /usr/local/Cellar/fzf/0.22.0/shell/key-bindings.zsh 
  source /usr/local/Cellar/fzf/0.22.0/shell/completion.zsh 
elif [[ $OS =~ "OpenBSD" ]]; then
  source /usr/local/share/fzf/zsh/key-bindings.zsh
  source /usr/local/share/fzf/zsh/key-bindings.zsh
else
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
