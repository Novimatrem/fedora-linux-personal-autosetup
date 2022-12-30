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

alias ins="sudo dnf install -y $1"

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
sudo dnf install simplescreenrecorder
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
dnfins chromium
dnfins links
dnfins torbrowser-launcher
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins org.gnome.Epiphany
#-/
#/

fullupdate

# Set up manual notes, drop a few.
touch /home/$(whoami)/NOTES.txt

lvnote "Notes: (to-do, AKA things I am yet to automate)-"

lvnote "Install the MVPS HOSTS file with this script https://gitlab.com/-/snippets/1992890"

lvnote "Follow your blog post to fully permanently disable mouse acceleration. https://novimatrem.gitlab.io/blog/2020/08/22/how-to-fully-properly-disable-mouse-acceleration-in-most-linux-distros-and-de.html "

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
snapins snap-store
snapins languagetool
snapins pngcrush --edge
snapins tetris-thefenriswolf
snapins telegram-desktop
snapins dm-tools
snapins scrcpy
sudo snap refresh
#-/
#/

# Install some flatpaks I use or depend upon.
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins com.adobe.Flash-Player-Projector
flatpakins com.zandronum.Zandronum
flatpakins com.eduke32.EDuke32
flatpakins net.sourceforge.fretsonfire
flatpakins org.zdoom.GZDoom
flatpakins org.ppsspp.PPSSPP
flatpakins org.zdoom.GZDoom
flatpak update
#-/
#/

# Install variety so that my wallpaper doesn't stay the same for too long.
dnfins variety
#/

# Various tools to improve performance
dnfins gamemode
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
mkdir /home/$(whoami)/Videomaking
mkdir /home/$(whoami)/Working
mkdir /home/$(whoami)/Working/Important
mkdir /home/$(whoami)/Applications
mkdir /home/$(whoami)/DnD
mkdir /home/$(whoami)/Flashes
mkdir "/home/$(whoami)/EMU Roms"
mkdir /home/$(whoami)/.icons
mkdir /home/$(whoami)/Pictures/Wallpapers
#-/
#/

# Scanner support
dnfins skanlite
#/

# Install osu!lazer
mkdir /home/$(whoami)/Applications
cd /home/$(whoami)/Applications
dnfins wget
wget https://github.com/ppy/osu/releases/latest/download/osu.AppImage
sudo chmod +x ./osu.AppImage
#-/
#/

# Make Xfce4 window buttons on the left and as I like them
xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|O"
#/

# Some disk tools
dnfins gnome-disk-utility
dnfins gnome-disks
dnfins gparted
#-/
#/

# redshift for eye protection
dnfins redshift-gtk
#/

# toot cli fedi client
dnfins toot
#/

# IDLE, for Python
dnfins idle
dnfins idle3
#-/
#/

# More browsers/terminal usability
dnfins lynx
dnfins links
dnfins w3m
dnfins w3m-img
dnfins links
dnfins links2
dnfins elinks
dnfins byobu
dnfins tmux
snapins dm-tools
#-/
#/

# NoteBot (by adolfintel / fdossena) install+autorun
dnfins wget

cd /opt
wget https://downloads.fdossena.com/Projects/StickyNotes/notebot-1.6-bin.7z
7z x notebot-1.6-bin.7z

sleep 0s && nohup java -jar "/opt/StickyNotes.jar" && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

#
# CREATE STARTUP PROGRAM ENTRY
#
mkdir /home/$(whoami)/.config/autostart
touch /home/$(whoami)/.config/autostart/notebot.desktop

echo "[Desktop Entry]" >> /home/$(whoami)/.config/autostart/notebot.desktop
echo "Type=Application" >> /home/$(whoami)/.config/autostart/notebot.desktop
echo "Name=notebot" >> /home/$(whoami)/.config/autostart/notebot.desktop
echo "Exec=java -jar /opt/StickyNotes.jar" >> /home/$(whoami)/.config/autostart/notebot.desktop
echo "Comment=notebot" >> /home/$(whoami)/.config/autostart/notebot.desktop
echo "Terminal=false" >> /home/$(whoami)/.config/autostart/notebot.desktop

echo ""
echo ""
echo "verify below:"
echo ""
ls /home/$(whoami)/.config/autostart/
echo ""
cat /home/$(whoami)/.config/autostart/notebot.desktop
echo ""
echo "done listing"
echo ""
echo ""
#
# /END OF CREATE STARTUP PROGRAM ENTRY
#
# /NoteBot (by adolfintel / fdossena) install+autorun

# Disable the Xfce4/Xfwm4 compositor because it's very input lag and meh
xfconf-query -c xfwm4 -p /general/use_compositing -s false
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
dnfins abiword
dnfins atril
dnfins baobab
dnfins ncdu
dnfins brasero
dnfins calibre
dnfins dosbox
dnfins dosbox-staging
dnfins filezilla
dnfins gimp
dnfins git
dnfins gnome-disks
dnfins gparted
dnfins gnome-system-monitor
dnfins xfce4-terminal
dnfins gnumeric
dnfins guvcview
dnfins cheese
dnfins languagetool
dnfins nano
dnfins neofetch
dnfins net-tools
dnfins nethogs
dnfins pavucontrol
dnfins playonlinux
dnfins skanlite
dnfins tmux
dnfins torbrowser-launcher
dnfins vlc
dnfins obs-studio
dnfins simplescreenrecorder
dnfins peek
dnfins handbrake
dnfins kdenlive
dnfins openshot
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins io.github.fabiangreffrath.Doom
dnfins oxygen-fonts
dnfins yaru-theme
dnfins lua
#-/
#/

# ensure-obs in home folder
cd /home/$(whoami)
dnfins wget
wget https://gitlab.com/Novimatrem/fedora-linux-personal-autosetup/-/raw/main/ensure-obs.sh
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

# Wayland adjacent
dnfins eglinfo
dnfins egl-utils
dnfins wayland-utils
#-/
#/

# Webdev browsers
dnfins firefox
dnfins chromium
dnfins links
dnfins torbrowser-launcher
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins org.gnome.Epiphany
#-/
#/

# More software
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins net.minetest.Minetest
dnfins steam
dnfins dino-im
dnfins dino
dnfins firefox
dnfins playonlinux
dnfins filezilla
dnfins gimp
dnfins guvcview
dnfins pavucontrol
dnfins gnome-system-monitor
dnfins xfce4-appfinder
dnfins gedit
dnfins obs-studio
dnfins cheese
dnfins dropbox
snapins spelunky
dnfins xbindkeys
dnfins xdotool
dnfins vlc
dnfins alsamixer
dnfins wmctrl
dnfins peek
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins info.mumble.Mumble
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

# a good theme
cd /opt/
git clone https://gitlab.com/Novimatrem/haiku-themes-linux
#-/
#/

# install plasma discover fully
sudo dnf install -y plasma-discover
sudo dnf install -y plasma-discover*
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf install -y plasma-discover-flatpak
sudo dnf install -y plasma-discover-offline-updates
sudo dnf install -y plasma-discover-packagekit
sudo dnf install -y plasma-discover-notifier
sudo dnf install -y plasma-discover-snap
#-/
#/

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
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins org.videolan.VLC
flatpakins com.obsproject.Studio
flatpakins fr.handbrake.ghb
flatpakins org.kde.kdenlive
flatpak install flathub org.audacityteam.Audacity
flatpakins com.wire.WireDesktop
snapins kdenlive
dnfins minigalaxy
dnfins skanlite
flatpakins com.skype.Client
flatpakins io.mrarm.mcpelauncher
dnfins steam
sudo snap install runelite --edge
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

# Calendar
sudo dnf install -y gnome-calendar
sudo dnf install -y gnome-tweaks
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

# Nestopia
# for some reason has an uppercase first letter for its package name in fedora
sudo dnf install -y Nestopia
#-/
#/

# OpenMW
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --from https://flathub.org/repo/appstream/org.openmw.OpenMW.flatpakref -y --noninteractive
#-/
#/

# Good cli apps for fixing bads
dnfins ncdu
dnfins htop
dnfins iotop
dnfins nvidia-smi
dnfins nethogs
#-/
#/

# Sadly not great anymore, something broke in gbe plus??
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remove flathub com.github.shonumi.gbe-plus -y --noninteractive
#-/
#/

# Gameboii emu
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins io.mgba.mGBA
#-/
#/

# Weather 2
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins org.kde.kweather
#-/
#/

# gnome software store and updater
sudo dnf install -y gnome-software
#-/
#/

# technic launcher
cd /opt
wget https://launcher.technicpack.net/launcher4/757/TechnicLauncher.jar
#-/
#/

# haguichi hamachi logmein
sudo dnf copr enable ztefn/haguichi
sudo dnf install haguichi
#-/
#/

# logmein hamachi
cd /opt
wget https://www.vpn.net/installers/logmein-hamachi-2.1.0.203-1.x86_64.rpm
sudo rpm -ivh logmein-hamachi-2.1.0.203-1.x86_64.rpm
#-/
#/

# xgamma
dnfins xgamma
#-/
#/

# snes9x flatpak
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins com.snes9x.Snes9x
#-/
#/

# m64p n64 emulator flatpak
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins io.github.m64p.m64p
#-/
#/

# ensure n64
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins io.github.simple64.simple64
#-/
#/

# improved unicode font and symbol support
sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y
sudo dnf makecache -y
sudo dnf install -y gdouros-aegean-fonts.noarch
sudo dnf install -y gdouros-aegyptus-fonts.noarch
sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y
#-/
#/

# regret
sudo snap install discord
sleep 5s
sudo snap connect discord:system-observe
#-/
#/

# fuse
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins net.sf.fuse_emulator
#/

# good mate start menu
dnfins mate-menu
#/

# burn baby burn
dnfins brasero
#/

# EasyEffects (formally PulseEffects)
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins com.github.wwmm.easyeffects
#/

# mari0
sudo snap install mari0 --edge
#/

# blue recorder flatpak install
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins sa.sy.bluerecorder
#/

# guarantee dnfdragora
# this program is very good
dnfins dnfdragora*
dnfins dnfdragora
dnfins dnfdragora-updater
#-/
#/

# required deps
sudo dnf install -y neofetch toilet figlet lolcat
#/

# xterm
dnfins xterm
#/

# gnome boxes
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins org.gnome.Boxes
#/

# grapejuice
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins net.brinkervii.grapejuice
#/

# powertop
dnfins powertop
#/

# atlauncher flatpak
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins com.atlauncher.ATLauncher
#/

# flatpak gajim and plugins
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install org.gajim.Gajim -y --noninteractive
flatpak install org.gajim.Gajim.Plugin.appindicator -y --noninteractive
flatpak install org.gajim.Gajim.Plugin.url_image_preview -y --noninteractive
flatpak install org.gajim.Gajim.Plugin.omemo -y --noninteractive
# ^ flatpak gajim and plugins /> 

# assaultcube
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins net.cubers.assault.AssaultCube
#/

# openarena
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins ws.openarena.OpenArena
#/

# osrs snap
sudo snap install os-runes
#/

# tweak-display
clear
echo "tweak-display.sh"
echo ""
echo "If prompted, enter your password to begin."
sudo echo "Installing dependency..."
echo ""
sudo dnf install ddcutil
sudo dnf remove -y redshift
sudo dnf remove -y redshift-gtk
killall redshift
killall redshift-gtk
pkill redshift
pkill redshift-gtk
echo ""

echo "Displaying current info about display."

echo ""
# sense brightness
sudo ddcutil -d 1 getvcp 10 | grep -v Unsupported

echo ""
# sense contrast
sudo ddcutil -d 1 getvcp 12 | grep -v Unsupported

echo ""
# sense color preset
sudo ddcutil -d 1 getvcp 14 | grep -v Unsupported

echo ""

echo "Tweaking display."
echo ""

# setting brightness
sudo ddcutil -d 1 setvcp -- 10 "100"

# setting contrast
sudo ddcutil -d 1 setvcp -- 12 "50"

# setting color mode
sudo ddcutil -d 1 setvcp -- 14 "0x01"

echo "New settings:"

echo ""
# sense brightness
sudo ddcutil -d 1 getvcp 10 | grep -v Unsupported

echo ""
# sense contrast
sudo ddcutil -d 1 getvcp 12 | grep -v Unsupported

echo ""
# sense color preset
sudo ddcutil -d 1 getvcp 14 | grep -v Unsupported

echo ""

# ElectronMail Flatpak
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins com.github.vladimiry.ElectronMail
#/

# Telegram Terminal CLI application
mkdir -p ~/.local/src
cd ~/.local/src
git clone https://github.com/TruncatedDinosour/arigram.git
cd arigram
./do local
alias brcappend='echo -e "\n$1\n" >> /home/$(whoami)/.bashrc'
brcappend "alias arigram='cd /home/$(whoami)/.local/src/arigram/ && arigram'"
#-/
#/

# srb2kart
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins org.srb2.SRB2Kart
#/

# Basic Chicago setup
mkdir /opt/chicago
cd /opt/chicago
git clone https://github.com/grassmunk/Chicago95
cd /opt/chicago/Chicago95
python3 /opt/chicago/Chicago95/installer.py

cd /opt/chicago
sudo cp -r Chicago95/Plymouth/Chicago95 /usr/share/plymouth/themes/
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/Chicago95/Chicago95.plymouth 100
sudo update-alternatives --config default.plymouth
sudo update-initramfs -u


# windows 95 window buttons
gsettings set org.gnome.desktop.wm.preferences button-layout ‘:maximize,minimize,close,close’
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ShellShowsAppMenu': <0>, 'Gtk/DecorationLayout': <':menu,maximize,minimize,close'>}"
gsettings set com.solus-project.budgie-wm button-layout ':appmenu,minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences button-layout close,maximize,minimize:maximize,minimize,close
dconf write /org/cinnamon/desktop/wm/preferences/button-layout "':maximize,minimize,close'"
xfconf-query -c xfwm4 -p /general/button_layout -s "O|MHC"
# /windows 95 window buttons

lvnote "To ensure your Win95/Chicago95 theme is working properly, follow this: https://github.com/grassmunk/Chicago95/blob/master/INSTALL.md"
#-/
#/

# 2023 wallpaper!
ins wget
ins dconf

cd /opt
mkdir 2023wall
cd /opt/2023wall

wget https://novimatrem.uk/2023wall.png

xfconf-query -c xfce4-desktop -l | grep last-image | while read path; do xfconf-query -c xfce4-desktop -p $path -s /opt/2023wall/2023wall.png; done
dconf write /org/cinnamon/desktop/background/picture-uri "'file:///opt/2023wall/2023wall.png'"
gsettings set org.gnome.desktop.background picture-uri file:///opt/2023wall/2023wall.png
dconf write /org/mate/desktop/background/picture-filename "'/opt/2023wall/2023wall.png'"
#-/
#/

# nevermind they ruined it
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remove -y com.gitlab.newsflash
#/

# Feeds RSS reader flatpak
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins flathub org.gabmus.gfeeds
#/

# MATE's desktop icon implementation isn't great. Disabling it the best I can.
dconf write /org/mate/caja/preferences/desktop-is-home-dir "false"
dconf write /org/mate/caja/desktop/computer-icon-visible "false"
dconf write /org/mate/desktop/background/show-desktop-icons "false"
dconf write /org/mate/caja/desktop/home-icon-visible "false"
dconf write /org/mate/caja/desktop/trash-icon-visible "false"
#-/
#/

# Wolf3D shareware snap
sudo snap install wolf3d
#/

# a qemu snap
sudo snap install qemu-virgil --edge
#/

# ensure mate-terminal
dnfins mate-terminal
#/

# video editor ensure
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo snap install kdenlive
flatpakins org.kde.kdenlive
flatpakins org.openshot.OpenShot
#-/
#/

# audio editor ensure
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
dnfins audacity
flatpakins org.audacityteam.Audacity
sudo snap install audacity
#-/
#/

# bucklespring
sudo snap install bucklespring --edge
lvnote "Ensure you setup a startup program for the command: bucklespring.buckle"
#/

# qjoypad snap
sudo snap install qjoypad-ahimta --candidate
sudo snap connect qjoypad-ahimta:joystick :joystick
sudo snap connect qjoypad-ahimta:joystick
#-/
#/

# retext
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins me.mitya57.ReText
#/

# melonds
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins net.kuribo64.melonDS
#/

# powerstat snap
sudo snap install powerstat
#/

# scrot
dnfins scrot
#/

# Install IceWM (Fedora)
echo "Install IceWM (Fedora)"

cd "$(dirname "$0")"

sudo dnf install -y lzip
sudo dnf install -y g++

sudo dnf install -y icewm
sudo dnf install -y icewm-clearlooks
sudo dnf install -y icewm-data
sudo dnf install -y icewm-minimal-session
sudo dnf install -y icewm-themes

wget https://ice-wm.org/scripts/os-depends.sh
sudo bash -x ./os-depends.sh
#-/
#/

# System upgrader
sudo dnf autoremove -y
sudo dnf check -y
sudo dnf upgrade -y
sudo dnf distro-sync -y
sudo dnf autoremove -y
sudo dnf check -y

sudo dnf install -y dnf-plugin-system-upgrade

sudo dnf autoremove -y
sudo dnf check -y
sudo dnf upgrade -y
sudo dnf distro-sync -y
sudo dnf autoremove -y
sudo dnf check -y
#/

# Element (Matrix) [previously known as Riot] flatpak
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins im.riot.Riot
#/

# Forcefully replace xterm with a symlink to another terminal
dnfins mate-terminal
sudo rm -rf /usr/bin/xterm
sudo ln -s /usr/bin/mate-terminal /usr/bin/xterm
#-/
#/

# LibreOffice
dnfins libreoffice
#/

# srb2
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins org.srb2.SRB2
#/

# wondershaper dnf
dnfins wondershaper
#/

# gba emulator for less capable machines
sudo snap install visualboyadvance-m --edge
#/

# micropolis snap
sudo snap install micropolis
#/

# openttd
dnfins openttd
dnfins openttd-docs
dnfins openttd-opengfx
#-/
#/

# ags
sudo snap install ags --edge
#/

# midi better hopefully maybe
sudo dnf install -y fluid*
#/

# scummvm for ags games (yahtzee's)
sudo snap install scummvm
#/

# osu!lazer flatpak
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins sh.ppy.osu
#/

# Make flatpaks good and working
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#/

# ensure gedit
dnfins gedit
sudo dnf install -y gedit
#-/
#/

# dropbox ensure
dnfins flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpakins com.dropbox.Client
#/

# ensure transmission
dnfins transmission
dnfins transmission-gtk
dnfins transmission-common
#-/
#/

# gnome clocks for reminders.
sudo dnf install -y gnome-clocks
dnfins gnome-clocks
#-/
#/

# deps
sudo dnf install -y espeak
dnfins espeak
dnfins fortune-mod
#-/
#/

# ghex
dnfins ghex
#/

# Install KDE Desktop on Fedora
echo "Working..."

sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y


sudo dnf update -y
sudo dnf upgrade -y
sudo dnf upgrade --refresh -y

sudo dnf install -y sddm
sudo systemctl enable sddm

sudo dnf groupinstall "KDE Plasma Workspaces"
sudo dnf group install kde-desktop-environment
sudo dnf install @kde-desktop-environment
sudo dnf install @kde-desktop

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf upgrade --refresh -y


sudo dnf autoremove -y && sudo dnf check -y && sudo dnf upgrade -y && sudo dnf distro-sync -y && sudo dnf autoremove -y && sudo dnf check -y

echo "Done."
echo ""
#-/
#/

# wallpaper engine working on linux yay!
# subscribe to wallpaper engine walls through its steam workshop, 
# get the files from where they download to in;
# /home/<your_username>/.steam/steam/steamapps/workshop/content/431960
# and then APPLY them in this app instead, known as Hidamari.
flatpakins io.github.jeffshee.Hidamari
flatpak install flathub io.github.jeffshee.Hidamari
#-/
#/

# quake 3
sudo dnf install -y quake3
sudo dnf install -y ioquake3
#-/
#/
