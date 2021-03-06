#!/bin/bash
### every exit != 0 fails the script
set -e

# Setting pidfile + command to execute
pidfile="$HOME/.vnc/*:1.pid"
command="vncserver -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -localhost no"




# Proxy signals
function kill_app(){
    kill $(cat $pidfile)
    exit 0 # exit okay
}
trap "kill_app" SIGINT SIGTERM

# Launch daemon
$command
sleep 2

# Loop while the pidfile and the process exist
while [ -f $pidfile ] && kill -0 $(cat $pidfile) ; do
    sleep 0.5
done
exit 1000 # exit unexpected