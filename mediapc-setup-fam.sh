#!/bin/bash
# mediapc-setup-fam.sh

#======================================================================#
: <<'COMMENT'

comment goes here

COMMENT
#======================================================================#

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

alias gtfo="zenity --warning --text 'Process complete. Shutting down in 1 minute. REFER TO NOTES.TXT IN HOME AFTER REBOOT.' & shutdown -h +1"

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
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout '0' && gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout '0'
killall mate-screensaver
pkill mate-screensaver
#-/
#/

# This is a really dumb way to do this, but literally everything else isn't working.
# fuckin computers, man
dnfins firefox
sleep 0s && nohup firefox https://www.youtube.com/watch?v=ep4JqcEX1qc && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown && echo ""
echo ""
#-/
#/

# wow, even that didn't work, let's xkcd 196 this fucker
sudo chown $USER /opt/
sudo chown $USER /opt/*
cd /opt && wget https://gitlab.com/Novimatrem/fedora-linux-personal-autosetup/-/raw/main/wobblemouse-wakeup.sh && nohup bash wobblemouse-wakeup.sh &
#-/
#/

# Set the keyboard layout to the one I prefer, QWERTY en-US.
setxkbmap -layout us -variant ,qwerty
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+qwerty')]"
brcappend "setxkbmap -layout us -variant ,qwerty"
#-/
#/

# Make flatpaks good and working
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#/

# allow nonfree, fixes a lot that i was missing, given i came from ubuntu
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#/

# but like for real, i'd really like some rpmfusion
sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
#-/
#/

# Remove GNOME from Fedora
echo "Working..."
sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y
sudo dnf remove -y jdk
sudo dnf remove -y jre
sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y
sudo yum groupremove gnome-desktop-environment
sudo dnf group remove gnome-desktop-environment
sudo dnf remove -y gnome-desktop3
sudo dnf remove -y gnome-session
sudo dnf remove -y gnome-session-wayland-session
sudo dnf remove -y gnome-session-xsession
sudo dnf remove -y gnome-shell
sudo dnf remove -y gnome-classic-session
sudo dnf remove -y gdm
sudo systemctl disable gdm
sudo systemctl remove gdm
sudo dnf remove -y *gnome*
sudo dnf remove -y @gnome-desktop
sudo dnf remove -y gnome-*
sudo dnf remove -y gnome
sudo dnf remove -y mutter
sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y
echo ""
#-/
#/

# Install some deps
dnfins wget
dnfins curl
dnfins xdotool
dnfins zenity
dnfins wget
dnfins sox
dnfins xbindkeys
dnfins ffmpeg
dnfins x11-utils
dnfins wmctrl
#-/
#/

# Install MATE Desktop on Fedora v7

# The MATE theme I use is known as GreenLaguna, it's not incredibly pretty, but, it means that
#  titlebar size, height, and the location, size, and position of the window buttons stays as
#   consistent as possible between apps/windowing toolkits, as this is very important to me,
#    and was the reason I can't use Xfce 4.16, due to how it treats this with GTK vs Non-GTK apps.

echo "Working..."

sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf upgrade --refresh -y

sudo dnf install -y sddm
sudo systemctl enable sddm

sudo dnf install -y mate-desktop
sudo dnf install -y @mate-desktop
sudo dnf groupinstall mate-desktop
sudo dnf -y group install "MATE Desktop"
sudo dnf install -y mate-desktop-environment

sudo dnf remove -y elementary-notifications
sudo dnf remove -y kf5-knotif*
sudo dnf remove -y lxqt-notificationd
sudo dnf remove -y notification-daemon

sudo dnf install -y mate-notification-daemon-common
sudo dnf install -y mate-notification-daemon

sudo dnf reinstall mate-notification-daemon-common
sudo dnf reinstall mate-notification-daemon

sudo dnf install -y mate-notification-daemon-common
sudo dnf install -y mate-notification-daemon

rpm -qa | grep notif >list
sudo dnf remove -y $(awk '{print $1}' <list)

sudo dnf install -y mate-notification-daemon-common
sudo dnf install -y mate-notification-daemon

sudo dnf reinstall mate-notification-daemon-common
sudo dnf reinstall mate-notification-daemon

sudo dnf install -y mate-notification-daemon-common
sudo dnf install -y mate-notification-daemon

# MATE applications
sudo dnf install -y @mate-applications
sudo dnf groupinstall mate-applications
#-/
#/

sudo dnf install -y mate-desktop
sudo dnf install -y @mate-desktop
sudo dnf groupinstall mate-desktop
sudo dnf -y group install "MATE Desktop"
sudo dnf install -y mate-desktop-environment
sudo dnf install -y @mate-applications
sudo dnf groupinstall mate-applications

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf upgrade --refresh -y

sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y

echo "Done."
echo ""

# Install browsers
dnfins firefox
dnfins torbrowser-launcher
#-/
#/

fullupdate

# Set up manual notes, drop a few.
touch /home/$(whoami)/NOTES.txt

lvnote "Notes: (to-do, AKA things I am yet to automate)-"

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
sudo echo -ne "\033[9;0]" >> /etc/issue
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout '0' && gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout '0'
killall mate-screensaver
pkill mate-screensaver
#-/
#/

# Create and own the /opt folder, because I use it very frequently.
sudo mkdir /opt
cd /opt/
sudo chown $USER /opt
sudo chown $USER /opt/*
#-/
#/

# Get ready to use snaps
dnfins snapd
sudo ln -s /var/lib/snapd/snap /snap
#-/
#/

# Install some snaps I use or depend upon.
snapins snapd
snapins hello-world
sudo snap refresh
#-/
#/

# Install some flatpaks I use or depend upon.
flatpakins com.adobe.Flash-Player-Projector
flatpakins net.sourceforge.fretsonfire
flatpak update
#-/
#/

# Install variety so that my wallpaper doesn't stay the same for too long.
dnfins variety
#/

# Various tools to improve performance
dnfins cpufrequtils
dnfins preload
sudo systemctl disable ondemand
#-/
#/

# Package to avoid hard crashing when running out of RAM, because Linux's OOM-killer sucks.
dnfins earlyoom
sudo systemctl enable earlyoom
sudo systemctl start earlyoom
sleep 0s && nohup earlyoom && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown && echo ""
echo ""
#-/
#/

# Make some folders that I want to frequently use.
mkdir /home/$(whoami)/Applications
mkdir /home/$(whoami)/.icons
mkdir /home/$(whoami)/Pictures/Wallpapers
#-/
#/

# Scanner support
dnfins skanlite
#/

# Some disk tools
dnfins gnome-disk-utility
dnfins gnome-disks
dnfins gparted
#-/
#/

# Text editors
dnfins kwrite
dnfins gedit
#-/
#/

# Cleanup
rm -rf /opt/nohup.out
rm -rf $HOME/nohup.out
rm -rf $(pwd)/nohup.out
rm -rf /home/$(whoami)/fast.sh
rm -rf /home/$(whoami)/Desktop/fast.sh
sudo chown $USER /opt/
sudo chown $USER /opt/*
rm -rf /opt/nohup.out
sudo rm -rf /opt/nohup.out
#-/
#/

# Install more software
dnfins baobab
dnfins ncdu
dnfins git
dnfins gnome-disks
dnfins gparted
dnfins gnome-system-monitor
dnfins nano
dnfins neofetch
dnfins net-tools
dnfins nethogs
dnfins pavucontrol
dnfins skanlite
dnfins tmux
dnfins torbrowser-launcher
dnfins vlc
dnfins oxygen-fonts
dnfins yaru-theme
#-/
#/

# time, part 1
timedatectl set-ntp yes
sudo timedatectl set-ntp yes
#-/
#/

# time, part 2
sudo systemctl enable systemd-timesyncd.service
sudo systemctl start systemd-timesyncd.service
timedatectl
timedatectl set-ntp true
sudo timedatectl set-ntp true
timedatectl
sleep 6s
sudo hwclock -w
hwclock -w
#-/
#/

# Webdev browsers
dnfins firefox
dnfins torbrowser-launcher
#-/
#/

# More software
dnfins firefox
dnfins pavucontrol
dnfins gnome-system-monitor
dnfins xfce4-appfinder
dnfins gedit
dnfins xbindkeys
dnfins xdotool
dnfins vlc
dnfins alsamixer
dnfins wmctrl
dnfins iotop
#-/
#/

# xinput (important)
dnfins xinput
#/

# theme note
lvnote "Ensure you apply a theme that's not one of those awful horrible -modern design- flat theme things, in all aspects you're allowed to customize."
#-/
#/

lvnote "ensure you follow your snippet to disable selinux and thus make selinux shut up forever: https://gitlab.com/-/snippets/2371794"

lvnote "Ensure you do all you can to make the system automatically log in."

# python for sure
dnfins python
dnfins python3
#-/
#/

# Install MATE Desktop on Fedora v7

# The MATE theme I use is known as GreenLaguna, it's not incredibly pretty, but, it means that
#  titlebar size, height, and the location, size, and position of the window buttons stays as
#   consistent as possible between apps/windowing toolkits, as this is very important to me,
#    and was the reason I can't use Xfce 4.16, due to how it treats this with GTK vs Non-GTK apps.

echo "Working..."

sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf upgrade --refresh -y

sudo dnf install -y sddm
sudo systemctl enable sddm

sudo dnf install -y mate-desktop
sudo dnf install -y @mate-desktop
sudo dnf groupinstall mate-desktop
sudo dnf -y group install "MATE Desktop"
sudo dnf install -y mate-desktop-environment

sudo dnf remove -y elementary-notifications
sudo dnf remove -y kf5-knotif*
sudo dnf remove -y lxqt-notificationd
sudo dnf remove -y notification-daemon

sudo dnf install -y mate-notification-daemon-common
sudo dnf install -y mate-notification-daemon

sudo dnf reinstall mate-notification-daemon-common
sudo dnf reinstall mate-notification-daemon

sudo dnf install -y mate-notification-daemon-common
sudo dnf install -y mate-notification-daemon

rpm -qa | grep notif >list
sudo dnf remove -y $(awk '{print $1}' <list)

sudo dnf install -y mate-notification-daemon-common
sudo dnf install -y mate-notification-daemon

sudo dnf reinstall mate-notification-daemon-common
sudo dnf reinstall mate-notification-daemon

sudo dnf install -y mate-notification-daemon-common
sudo dnf install -y mate-notification-daemon

# MATE applications
sudo dnf install -y @mate-applications
sudo dnf groupinstall mate-applications
#-/
#/

sudo dnf install -y mate-desktop
sudo dnf install -y @mate-desktop
sudo dnf groupinstall mate-desktop
sudo dnf -y group install "MATE Desktop"
sudo dnf install -y mate-desktop-environment
sudo dnf install -y @mate-applications
sudo dnf groupinstall mate-applications

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf upgrade --refresh -y

sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y

echo "Done."
echo ""
#-/
#/

# Extra apps that are important
flatpakins org.videolan.VLC
dnfins skanlite
sudo dnf install -y xfce4-appfinder
#-/
#/

# only 1 workspace, please.
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
gsettings set org.cinnamon.desktop.wm.preferences num-workspaces 1
gsettings set org.mate.Marco.general num-workspaces 1
#-/
#/

# Minecraft Java generic autoinstall
sudo echo "Starting Minecraft install..."

sudo mkdir /opt/

sudo chown $USER /opt
sudo chown $USER /opt/
sudo chown $USER /opt/*

sudo mkdir /opt/novi-minecraft

sudo chown $USER /opt/novi-minecraft

cd /opt/novi-minecraft

sudo wget https://launcher.mojang.com/download/Minecraft.tar.gz

sudo chown $USER /opt/novi-minecraft/Minecraft.tar.gz

tar -xzvf Minecraft.tar.gz

sleep 2s

sudo rm -rf /opt/novi-minecraft/Minecraft.tar.gz

ln -s /opt/novi-minecraft/minecraft-launcher/minecraft-launcher /home/$(whoami)/Desktop/Minecraft

echo "Minecraft done, shortcut is on your desktop."
#-/
#/

# Allow setting GNOME-ish app themes to something better and darker
sudo dnf install -y gnome-tweaks
#-/
#/

# Weather
sudo dnf install -y gnome-weather
#/

# More good gnome apps, final
dnfins gnome-characters
dnfins gnome-system-monitor
dnfins gnome-backgrounds
#-/
#/

# Good cli apps for fixing bads
dnfins ncdu
dnfins htop
dnfins iotop
dnfins nethogs
#-/
#/

# Weather 2
flatpakins org.kde.kweather
#-/
#/

# gnome software store and updater
sudo dnf install -y gnome-software
#-/
#/

# xgamma
dnfins xgamma
#-/
#/

# transmission
dnfins transmission
#/

# improved unicode font and symbol support
sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y
sudo dnf makecache -y
sudo dnf install -y gdouros-aegean-fonts.noarch
sudo dnf install -y gdouros-aegyptus-fonts.noarch
sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y
#-/
#/

# fedora yolo auto
brcappend "alias yolo='sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y'"
#-/
#/

# good mate start menu
dnfins mate-menu
#/

lvnote "Ensure you go and setup the Power Management settings in the Control Center, to set it to Never do anything automatically, and Never do anything with the lid switch."

lvnote "also make sure you go into mate-screensaver's settings in a similar place and disable that fully, also."

echo "DONE! REBOOT NOW!"


