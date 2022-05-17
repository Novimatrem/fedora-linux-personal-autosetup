# wobblemouse-wakeup.sh
sudo dnf install -y xdotool
while sleep 1; do sleep 1s && xdotool mousemove 300 300 && sleep 1s && xdotool mousemove 330 330 && sleep 1s && xdotool mousemove_relative 20 20 && sleep 1s && xdotool mousemove_relative -- -10 -10 && xdotool mousemove_relative -- -30 -30; done
