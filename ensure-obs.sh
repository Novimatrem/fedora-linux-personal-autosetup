#!/bin/bash
clear
cd "$(dirname "$0")"
chmod +x $(pwd)/ensure-obs.sh

cd /home/$(whoami)

sleep 2s && nohup obs --startvirtualcam --startrecording --startreplaybuffer && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown && echo ""

# obs --startvirtualcam --startrecording --startreplaybuffer

# Cleanup
rm -rf /opt/nohup.out
rm -rf $HOME/nohup.out
rm -rf $(pwd)/nohup.outh
#-/
#/

clear
echo "OBS is doing the things exactly as you want it, kitty-cat."
echo ""
echo "Close this Terminal now, right now."
echo ""
exit

# meow
