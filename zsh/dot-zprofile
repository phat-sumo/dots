[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" > /dev/null
[ -z "$TMUX" ] && trap 'test -n "$SSH_AGENT_PID" && eval `/usr/bin/ssh-agent -k` > /dev/null' 0

#export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=kvantum

# ryuko autostart
# keep tmux from being dumb and autostart x server if we're on tty1 
if [[ $HOST == "ryuko" && -z "$TMUX" && $XDG_VTNR -eq 1 ]]; then

USAGE="  q quit 
  m mobile
  s stationed"
  echo "where are you?"

  while read -rs -k1 key; do
    case $key in
      q) break ;;
      s) sudo stationed; startx ;;
      m) sudo mobile; startx ;;
      [h?]) echo "$USAGE";;
    esac
  done
  
elif [[ $HOST == "gamagoori" && -z "$TMUX" && "$(fgconsole 2> /dev/null)" -eq 1 ]]; then
USAGE="  q quit 
  press any key to continue"
  echo "welcome back. staying long?"

  while read -rs -k1 key; do
    case $key in
      q) break ;;
      [h?]) echo "$USAGE";;
      *) startx ;;
    esac
  done
fi 
