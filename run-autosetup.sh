#!/bin/bash

# Start
echo ""
echo "run-autosetup.sh launched."
echo ""
#-/
#/

# Ask the user if they're sure, this process is not easily reversible
read -p "Begin setup [no way to undo] (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "" && echo "Begin NOW" && echo "";
else
  echo "" && echo "Setup ended by user choice" && echo "" && exit;
fi
#-/
#/

# Enable additional verbosity
set -x
#/

# Check if we're running as the correct user, this script must not be ran as root or with sudo.
echo "Checking if the correct user..."

if [[ $EUID -eq 0 ]]; then
    echo "Do not run this as the root user, or with sudo. Ending!"
    exit 1
fi
echo "Not root, good, continuing!"
#-/
#/

# Checking if the script has already ran before, because it must only be ran once per-install.
echo "Checking if already ran before..."

if [ -f /opt/novisetup.done ]; then
    echo "Ran before, ending! This script should only be ran once per fresh install!" && exit
fi

if [ ! -f /opt/novisetup.done ]; then
    echo "Not ran before, continuing!"
fi

echo "Ranwhen sanity check complete."
#-/
#/

# The following line makes this entire script work based on my programming style.
shopt -s expand_aliases
#/

# Set the keyboard layout to the one I prefer, QWERTY en-US.
setxkbmap -layout us -variant ,qwerty
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+qwerty')]"
#-/
#/


# Aliases
# Don't actually use these aliases anywhere else,
# They're dumb and for script tidy only
alias dnfins="sudo dnf install -y $1"

alias snapins="sudo snap install $1"

alias flatpakins="flatpak install flathub $1 -y --noninteractive"

alias fullupdate="sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y"

alias gtfo="zenity --warning --text 'Process complete. Shutting down in 1 minute.' & shutdown -h +1"

alias saybox='zenity --warning --text $1'

alias lvnote='echo -e "\n$1\n" >> /home/$(whoami)/NOTES.txt'

alias brcappend='echo -e "\n$1\n" >> /home/$(whoami)/.bashrc'

alias asksudo='echo "If asked, please enter your sudo password to allow the script to work;" && sudo echo "Asking for sudo complete."'
#-/
#/

# Let's begin properly.
asksudo
#/

# Mark the script to not run again, after this time
# as it is designed to be ran once only.
sudo mkdir /opt
cd /opt
sudo chown $USER /opt
sudo touch /opt/novisetup.done
sudo chown $USER /opt/novisetup.done
#-/
#/

# Kill things that may be in the way,
# given this is meant to be ran on a fresh install, nothing is happening,
# so it's relatively safe to do this- I know what I'm doing.
killall update-manager
killall dpkg
killall apt
pkill update-manager
pkill dpkg
pkill apt
killall packagekit
pkill packagekit
sudo killall update-manager
sudo killall dpkg
sudo killall apt
sudo pkill update-manager
sudo pkill dpkg
sudo pkill apt
sudo killall packagekit
sudo pkill packagekit
#-/
#/

# Ensure the system doesn't fall asleep in any way, to the best of my ability, that would be bad to occur during this.
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-display-ac 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-display-battery 0
gsettings set org.gnome.desktop.session idle-delay 0
sudo gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
sudo gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
sudo setterm -blank 0 -powersave off -powerdown 0
sudo xset s 0 0
sudo xset dpms 0 0
sudo xset s off
xset -dpms
xset s noblank
xset s off
gsettings set org.gnome.settings-daemon.plugins.power active false
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
setterm -blank 0
setterm -blank 0 -powerdown 0
sudo chown $USER /etc/issue
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-display-ac 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-display-battery 0
gsettings set org.gnome.desktop.session idle-delay 0
sudo gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
sudo gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
sudo setterm -blank 0 -powersave off -powerdown 0
sudo xset s 0 0
sudo xset dpms 0 0
sudo xset s off
xset -dpms
xset s noblank
xset s off
gsettings set org.gnome.settings-daemon.plugins.power active false
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
setterm -blank 0
setterm -blank 0 -powerdown 0
sudo chown $USER /etc/issue
sudo echo -ne "\033[9;0]" >> /etc/issue
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
#-/
#/

# Set the keyboard layout to the one I prefer, QWERTY en-US.
setxkbmap -layout us -variant ,qwerty
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+qwerty')]"
brcappend "setxkbmap -layout us -variant ,qwerty"
#-/
#/

# Make flatpaks good and working
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#/

# Install some deps
dnfins wget
dnfins curl
#-/
#/

# Install browsers
dnfins firefox
dnfins chromium
dnfins links
dnfins torbrowser-launcher
flatpakins org.gnome.Epiphany
#-/
#/


