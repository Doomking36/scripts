#Start Sx Automatically
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
. sx sh ~/.config/chadwm/scripts/run.sh
logout
fi
