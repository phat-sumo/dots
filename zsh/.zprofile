[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" > /dev/null

USAGE="  q quit 
  s stationed
  m mobile"

# ryuko autostart
# keep tmux from being dumb and autostart x server if we're on tty1 
if [[ $HOST == "ryuko" && -z "$TMUX" && $XDG_VTNR -eq 1 ]]; then

  echo "where are you?"

  while read -rs -k1 key; do
    case $key in
      q) break ;;
      s) sudo stationed; startx ;;
      m) sudo mobile; startx ;;
      [h?]) echo "$USAGE";;
    esac
  done
  
fi
