# keep tmux from being dumb
if [ -z "$TMUX" ]; then

  # autostart x server if we're on tty1
  if [[ $XDG_VTNR -eq 1 ]]; then
    startx
  fi

fi
