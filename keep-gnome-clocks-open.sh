#!/bin/bash
# keep-gnome-clocks-open.sh
# i shouldn't have to do this.. alas.. :/
# set as a startup program in your startup applications GUI thing.
# requires libnotify / libnotify-bin to be installed, aka a working notify-send command.

clear

echo "keep-gnome-clocks-open.sh"
echo "Launching..."
echo ""

while true;
do
    # Gather data
    COMPAREAGAINST=$(pgrep gnome-clocks)
    sleep 1s
    echo "gnome-clocks PID:"
    echo $COMPAREAGAINST
    
    
    #Check what we've got against what's expected
    if [[ -z "$COMPAREAGAINST" ]]; then
    sleep 0s && nohup gnome-clocks && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown && echo ""
    echo ""
    clear
    echo "keep-gnome-clocks-open.sh"
    echo ""
    echo "Checking..."
    echo "Okay, let's take a look."
    echo ""
    echo "gnome-clocks has crashed or otherwise closed. Notifying and trying to fix that!"
    notify-send "gnome-clocks had crashed or otherwise closed. Restarting it!"
    echo "Working..."
    echo ""

    # Launch code goes here.
    sleep 1s
    fi

    # Loop
    echo ""
    echo "Checking status..."
    echo "Seems fine to me! All good."
    echo "gnome-clocks is either open actively, or is the in 'the background'."
    echo ""
    # Let's check again. 2 sec delay to avoid lagging the CPU.
    sleep 2s
done

echo "you should never see this"
