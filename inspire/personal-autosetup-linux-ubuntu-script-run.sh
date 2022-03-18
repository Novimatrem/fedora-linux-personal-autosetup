# VERSION;
#
# MILESTONE 7!!
#

#!/bin/bash

read -p "Begin setup [no way to undo] (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "" && echo "Begin NOW" && echo "";
else
  echo "" && echo "Setup ended by user choice" && echo "" && exit;
fi


set -x
# Novimatrem personal-autosetup-linux Ubuntu
echo "Novimatrem personal-autosetup-linux Ubuntu"

echo "Checking if the correct user..."

if [[ $EUID -eq 0 ]]; then
    echo "Do not run this as the root user, or with sudo. Ending!"
    exit 1
fi

echo "Not root, good, continuing!"

echo "Checking if already ran before..."

if [ -f /opt/novisetup.done ]; then
    echo "Ran before, ending! This script should only be ran once per fresh install!" && exit
fi

if [ ! -f /opt/novisetup.done ]; then
    echo "Not ran before, continuing!"
fi

echo "Ranwhen sanity check complete."


echo ""
echo "Checking if you're running Pop, because Pop doesn't work with this script, and"
echo "will never work because Pop developers need to learn how to set their package dependencies properly."
echo ""
sudo rm -rf /tmp/check-if-pop-bad.txt

sudo apt install -y liblinux-distribution-perl

perl -e '
    use Linux::Distribution qw(distribution_name distribution_version);

    my $linux = Linux::Distribution->new;
    if(my $distro = $linux->distribution_name()) {
          my $version = $linux->distribution_version();
          print "$distro";
    } else {
          print "nevermind";
    }
' >> /tmp/check-if-pop-bad.txt
echo ""
echo "You are running:"
echo ""
cat /tmp/check-if-pop-bad.txt
echo ""
echo ""

VARFILECONTENTS="$(cat /tmp/check-if-pop-bad.txt)"

echo "Now inside of a variable which is:"
echo $VARFILECONTENTS

echo ""

echo "Checking..."

echo ""


if [ $VARFILECONTENTS = 'pop' ]; then
	echo "" && echo "You are running Pop, this script does not work on Pop." && echo "Please nuke and pave (fully format) your OS disk, and fresh install another distro. I recommend Xubuntu for this." && echo "" && exit & exit
fi

echo "Good news, you're not running Pop, so we can continue."

echo ""

# the following line makes this entire script work
shopt -s expand_aliases

#setxkbmap dvorak
#gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+dvorak')]"
setxkbmap -layout us -variant ,qwerty
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+qwerty')]"


sudo dpkg --add-architecture i386 

# aliases

# don't actually use these aliases anywhere else,
# they're dumb and for script tidy only

alias ins="sudo apt install -y $1"

alias insdeb="sudo gdebi -n $1"

alias insNIR="sudo apt install -y $1 --no-install-recommends"

alias uppy="sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo dpkg --configure -a && sudo apt-get -f install"

alias arepo="sudo add-apt-repository -y $1"

alias swake="cd /opt && wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/wobblemouse-wakeup.sh && nohup bash wobblemouse-wakeup.sh &"

alias gtfo="zenity --warning --text 'Process complete. Shutting down in 1 minute. REFER TO NOTES.TXT IN HOME AFTER REBOOT.' & shutdown -h +1"

alias sey='zenity --warning --text $1'

alias lvnote='echo -e "\n$1\n" >> /home/$(whoami)/NOTES.txt'

alias brcappend='echo -e "\n$1\n" >> /home/$(whoami)/.bashrc'

alias asksudo='echo "If asked, please enter your sudo password to allow the script to work;" && sudo echo "Asking for sudo complete."'
# />

# init

asksudo

# mark the script to not run again, after this time
# as it is designed to be ran once only
sudo mkdir /opt
cd /opt
sudo chown $USER /opt
sudo touch /opt/novisetup.done
sudo chown $USER /opt/novisetup.done

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

sleep 5s

#uppy # commented out for speed
sudo apt update -y

ins python-is-python3

ins caffeine
ins software-properties-common
ins software-properties-gtk

sleep 0s && nohup caffeine && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

sleep 0s && nohup caffeine-indicator && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

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


# script deps (but they are also really useful)
ins xdotool
ins zenity
ins wget
ins gdebi
ins gdebi-core
ins caffeine
ins software-properties-common
ins software-properties-gtk
# />

#sey "You will be unable to use the mouse until this process is complete. Press OK to start."

touch /home/$(whoami)/NOTES.txt

lvnote "Notes: (to-do, AKA things I am yet to automate)-"

lvnote "Started executing Novimatrem personal-autosetup-linux Ubuntu at around $(date)"

swake

ins python-is-python3

ins caffeine
ins software-properties-common
ins software-properties-gtk

sleep 0s && nohup caffeine && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

sleep 0s && nohup caffeine-indicator && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

echo ""
echo ""
echo ""
echo ""
echo "!!!"
echo "MILESTONE 7!!"
echo "!!!"
echo ""
echo ""
echo ""
echo ""

sleep 0s && nohup zenity --warning --text "MILESTONE 7!!" && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

lvnote "This is MILESTONE 7"

ins build-essential

uppy

# dvorak keyboard layout
#gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+dvorak')]"
#sudo dpkg-reconfigure keyboard-configuration
#brcappend "setxkbmap dvorak"
setxkbmap -layout us -variant ,qwerty
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+qwerty')]"
sudo dpkg-reconfigure keyboard-configuration
brcappend "setxkbmap -layout us -variant ,qwerty"

# />

ins gdebi
ins wget
ins curl
ins gdebi
ins gdebi-core
ins caffeine
ins software-properties-common
ins software-properties-gtk

ins hunspell-en-za
ins libreoffice-help-en-gb
ins hyphen-en-ca
ins mythes-en-au
ins hunspell-en-ca
ins hunspell-en-au
ins libreoffice-l10n-en-gb
ins libreoffice-help-en-us
ins libreoffice-l10n-en-za

# !!!
# UNINSTALL GNOME 3
# !!!

uppy

sudo apt remove -y adwaita-icon-theme gedit-common gir1.2-gdm-1.0 \
gir1.2-gnomebluetooth-1.0 gir1.2-gnomedesktop-3.0 gir1.2-goa-1.0 \
gnome-accessibility-themes gnome-bluetooth gnome-calculator gnome-calendar \
gnome-characters gnome-control-center gnome-control-center-data \
gnome-control-center-faces gnome-desktop3-data \
gnome-font-viewer \
gnome-initial-setup gnome-keyring gnome-keyring-pkcs11 gnome-logs \
gnome-mahjongg gnome-menus gnome-mines gnome-online-accounts \
gnome-power-manager gnome-screenshot gnome-session-bin gnome-session-canberra \
gnome-session-common gnome-settings-daemon gnome-settings-daemon-common \
gnome-shell gnome-shell-common gnome-shell-extension-appindicator \
gnome-shell-extension-desktop-icons gnome-shell-extension-ubuntu-dock \
gnome-startup-applications gnome-sudoku gnome-system-monitor gnome-terminal \
gnome-terminal-data gnome-themes-extra gnome-themes-extra-data gnome-todo \
gnome-todo-common gnome-user-docs gnome-user-docs-ru gnome-video-effects \
language-pack-gnome-en language-pack-gnome-en-base language-pack-gnome-ru \
language-pack-gnome-ru-base language-selector-gnome libgail18 libgail18 \
libgail-common libgail-common libgnome-autoar-0-0 libgnome-bluetooth13 \
libgnome-desktop-3-19 libgnome-games-support-1-3 libgnome-games-support-common \
libgnomekbd8 libgnomekbd-common libgnome-menu-3-0 libgnome-todo libgoa-1.0-0b \
libgoa-1.0-common libpam-gnome-keyring libsoup-gnome2.4-1 libsoup-gnome2.4-1 \
nautilus-extension-gnome-terminal pinentry-gnome3 yaru-theme-gnome-shell

uppy

sudo apt remove -y adwaita-icon-theme geogebra-gnome gir1.2-gtd-1.0 \
gnome-accessibility-profiles gnome-applets-data gnome-audio gnome-backgrounds \
gnome-cards-data gnome-common gnome-desktop-testing gnome-dvb-daemon \
gnome-extra-icons gnome-flashback-common \
gnome-humility-icon-theme gnome-hwp-support gnome-icon-theme \
gnome-icon-theme-gartoon gnome-icon-theme-gartoon-redux \
gnome-icon-theme-gperfection2 gnome-icon-theme-nuovo gnome-icon-theme-suede \
gnome-icon-theme-yasis gnome-mime-data gnome-nds-thumbnailer \
gnome-packagekit-data gnome-panel-control gnome-panel-data \
gnome-pkg-tools gnome-recipes-data gnome-remote-desktop gnome-settings-daemon-dev \
gnome-shell-pomodoro-data gnome-software-common gnome-software-doc \
gnome-theme-gilouche gnome-video-effects-extra gnome-video-effects-frei0r \
guile-gnome2-dev guile-gnome2-glib libgnome-autoar-doc libgnomecanvas2-common \
libgnomecanvas2-doc libgnomecanvasmm-2.6-doc libgnome-panel-doc libgnome-todo-dev \
libopenrawgnome7:amd64 libopenrawgnome-dev libreoffice-gnome libxine2-gnome:amd64 \
nautilus-sendto pidgin-gnome-keyring plymouth-theme-ubuntu-gnome-logo \
plymouth-theme-ubuntu-gnome-text ubuntu-gnome-wallpapers \
ubuntu-gnome-wallpapers-trusty ubuntu-gnome-wallpapers-utopic \
ubuntu-gnome-wallpapers-xenial ubuntu-gnome-wallpapers-yakkety

uppy

sudo apt remove -y ubuntu-gnome-desktop
sudo apt remove -y gnome-shell 

uppy

sudo apt remove -y gdm  

uppy

sudo apt remove -y gnome-shell

sudo apt remove -y ubuntu-gnome-desktop

sudo apt remove -y gnome-session 

sudo apt remove -y gnome

sudo apt remove -y gnome-core

sudo apt remove -y vanilla-gnome-desktop

sudo apt remove -y vanilla-gnome-default-settings

sudo apt remove -y ubuntu-gnome-default-settings

sudo apt remove -y ubuntu-session

uppy
# !!!
# /UNINSTALL GNOME 3
# !!!

ins gdebi
ins gdebi-core
ins caffeine
ins software-properties-common
ins software-properties-gtk

# power saving
ins tlp
sudo systemctl enable tlp
sudo systemctl start tlp
sudo tlp start

ins powertop

ins mbpfan
# />

insNIR gnome-tweaks

ins sox

# unicode and emoji
ins ttf-ancient-fonts
ins fonts-noto-color-emoji
ins fonts-recommended
ins gnome-characters
# />

# all archive support
ins unrar
ins zip
ins unzip
ins p7zip-full
ins p7zip-rar
ins rar
ins unace
ins sharutils
ins uudeview
ins mpack
ins arj
ins cabextract
ins file-roller
# />

ins xbindkeys

ins ffmpeg

# terminal games
ins nethack-console
ins moon-buggy
ins ninvaders
ins nsnake
ins pacman4console
ins bsdgames
ins typespeed
ins vitetris
ins frotz
insNIR emacs
ins emacs-nox
# />

lvnote "Install the MVPS HOSTS file with this script https://gitlab.com/-/snippets/1992890"

insNIR xfce4-appfinder

ins stacer
ins bleachbit

ins vlc

ins unrar
ins zip
ins unzip
ins p7zip-full
ins p7zip-rar
ins rar
ins unace
ins sharutils
ins uudeview
ins mpack
ins arj
ins cabextract
ins file-roller
ins debhelper-compat
ins dh-sequence-python3
ins python3
ins python3-yaml
ins python3-setuptools
ins python3-requests
ins python3-pil
ins python3-gi
ins gir1.2-gtk-3.0
ins gir1.2-glib-2.0
ins gir1.2-gnomedesktop-3.0
ins gir1.2-webkit2-4.0
ins gir1.2-notify-0.7
ins libgirepository1.0-dev
ins python3-yaml
ins python3-requests
ins python3-pil
ins python3-gi
ins python3-setproctitle
ins python3-distro
ins gir1.2-gtk-3.0
ins gir1.2-gnomedesktop-3.0
ins gir1.2-webkit2-4.0
ins gir1.2-notify-0.7
ins psmisc
ins cabextract
ins unzip
ins p7zip
ins curl
ins fluid-soundfont-gs
ins x11-xserver-utils
ins mesa-utils
ins python3-evdev
ins gvfs-backends
ins libwine-development
ins winetricks
ins libc6-i386
ins lib32gcc-s1
ins gamemode
ins build-essential
ins libgnutls30:i386
ins libldap-2.4-2:i386
ins libgpg-error0:i386
ins libxml2:i386
ins libasound2-plugins:i386
ins libsdl2-2.0-0:i386
ins libfreetype6:i386
ins libdbus-1-3:i386
ins libsqlite3-0:i386
ins wine-development
ins wine64-development
ins playonlinux
ins software-properties-common
ins software-properties-gtk
uppy

# wire - wireapp
cd /opt
wget https://github.com/wireapp/wire-desktop/releases/download/linux%2F3.19.2928/Wire-3.19.2928_amd64.deb
insdeb ./Wire-3.19.2928_amd64.deb
# />

# pts
cd /opt
wget http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_9.8.0_all.deb
insdeb ./phoronix-test-suite_9.8.0_all.deb
# />

# geekbench
cd /opt
wget http://cdn.geekbench.com/Geekbench-5.2.3-Linux.tar.gz
# />

# heaven
cd /opt
wget https://assets.unigine.com/d/Unigine_Heaven-4.0.run
sudo chmod +x ./Unigine_Heaven-4.0.run
# />

# vscodium
cd /opt
wget https://github.com/VSCodium/vscodium/releases/download/1.48.0/codium_1.48.0-1597345748_amd64.deb
insdeb ./codium_1.48.0-1597345748_amd64.deb
# />

# blender open data benchmark
cd /opt
wget https://opendata.blender.org/cdn/BlenderBenchmark2.0/launcher/benchmark-launcher-2.0.5-linux.tar.gz
# />

# gajim (no more)
sudo apt purge -y gajim-antispam
sudo apt purge -y gajim-plugininstaller
sudo apt purge -y gajim-appindicatorintegration
sudo apt purge -y gajim-omemo
sudo apt purge -y gajim-urlimagepreview
sudo apt purge -y gajim
# />

#lvnote "Do all the things listed here (Dvorak): https://gitlab.com/-/snippets/1997412"

ins armagetronad
ins feedreader
ins pavucontrol
ins guvcview
ins cheese
ins audacity
ins simplescreenrecorder
ins openshot
insNIR kdenlive
ins psensor
ins gnome-system-monitor
ins gnome-backgrounds
ins ubuntu-wallpapers
sudo apt-get install -y ubuntu-wallpapers*
ins steam
ins nautilus-dropbox
ins kolourpaint
ins calibre
ins atril
ins gedit
ins git
ins gnome-weather
ins localepurge
ins pavucontrol
ins transmission
ins vlc
ins abiword
ins baobab
ins ncdu
ins bleachbit
ins blueman
ins brasero
ins crispy-doom
ins freedoom
ins gnome-disk-utility
ins gparted
ins htop
ins gnumeric
ins handbrake
ins jstest-gtk
ins libreoffice
ins neofetch
ins net-tools
ins nethogs
ins peek
ins pencil2d
ins playonlinux
ins psensor
ins pylint
ins qjoypad
ins tmux
ins torbrowser-launcher
ins transmission
ins assaultcube
ins caffeine
ins software-properties-common
ins software-properties-gtk

ins ffmpeg
ins obs-studio

lvnote "Follow your blog post to fully permanently disable mouse acceleration. https://novimatrem.gitlab.io/blog/2020/08/22/how-to-fully-properly-disable-mouse-acceleration-in-most-linux-distros-and-de.html "

#ins wget
#cd /opt
#wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/gamera.png
#gsettings set org.gnome.desktop.background picture-uri file:///opt/gamera.png
#cd /opt
#mkdir gamera
#wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/gamera.png

ins wget
cd /opt
#wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/ubuntenwall.png
#gsettings set org.gnome.desktop.background picture-uri file:///opt/ubuntenwall.png
cd /opt
#mkdir ubuntenwall
#cd /opt/ubuntenwall
#wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/ubuntenwall.png

gsettings set org.gnome.desktop.wm.preferences button-layout ‘close,close,minimize,maximize:’

gsettings set org.gnome.desktop.app-folders folder-children ['']

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


sudo add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner" -y

ins libimage-exiftool-perl
ins flatpak
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# brackets editor (for markdown)
cd /opt
wget https://github.com/adobe/brackets/releases/download/release-1.14.1/Brackets.Release.1.14.1.64-bit.deb
insdeb ./Brackets.Release.1.14.1.64-bit.deb
# />

flatpak install flathub io.brackets.Brackets -y --noninteractive

cd /opt
tar -xvzf benchmark-launcher-2.0.5-linux.tar.gz -C /opt
tar -xvzf Geekbench-5.2.3-Linux.tar.gz -C /opt

sudo chmod +x /opt/benchmark-launcher-2.0.5-linux/benchmark-launcher
sudo chmod +x /opt/Geekbench-5.2.3-Linux/geekbench5
sudo chmod +x /opt/Geekbench-5.2.3-Linux/geekbench_x86_64

cd /opt
sudo chmod +x /opt/Unigine_Heaven-4.0.run
/opt/Unigine_Heaven-4.0.run

# vbox
cd /opt
ins virtualbox
# />

# gog (minigalaxy)
cd /opt
wget https://github.com/sharkwouter/minigalaxy/releases/download/0.9.4/minigalaxy_0.9.4_all.deb
insdeb ./minigalaxy_0.9.4_all.deb
# />

# itch.io app
cd /opt

#wget https://nuts.itch.zone/download/linux
#sudo chmod +x ./linux
#./linux
#sudo rm -rf ./linux

# they changed how its downloaded, new method;
cd /opt
wget -cO - https://itch.io/app/download?platform=linux > itch-new
sudo chmod +x ./itch-new
./itch-new

# />

ins eog

# ensure window buttons left more (and for budgie)
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ShellShowsAppMenu': <0>, 'Gtk/DecorationLayout': <'close,minimize,maximize,menu:'>}"
gsettings set com.solus-project.budgie-wm button-layout 'close,maximize,minimize,appmenu:'
gsettings set org.gnome.desktop.wm.preferences button-layout close,minimize,maximize:minimize,maximize,close

#lvnote "Install this alias https://gitlab.com/Novimatrem/dvorak-qwerty-switch-aliases"

#lvnote "Install this alarm clock https://gitlab.com/Novimatrem/alarm-clock so you can wake up"

ins filezilla

sudo apt remove -y sddm

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo apt install -y build-essential

sudo apt install -y git


sudo mkdir /opt
cd /opt/
sudo chown $USER /opt
sudo chown $USER /opt/*

sudo apt remove -y icewm-experimental

sudo apt remove -y icewm icewm

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo apt install -y libnotify-bin
sudo apt install -y xfce4-notifyd

echo ""
echo "Installing ALL the Xfce..."
echo ""

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo apt install -y lightdm
sudo systemctl enable lightdm
sudo dpkg-reconfigure lightdm

sudo apt install -y xfce4
sudo apt install -y xubuntu-default-settings
sudo apt install -y xfce4-goodies

sudo apt-get install -y xfce4*

sudo apt install -y tasksel

sudo tasksel install xubuntu-desktop
sudo tasksel install xubuntu-core

ins xubuntu-artwork
ins xubuntu-community-wallpapers-xenial
ins xubuntu-icon-theme
ins xubuntu-community-wallpapers
ins xubuntu-core
ins xubuntu-live-settings
ins xubuntu-community-wallpapers-bionic
ins xubuntu-default-settings
ins xubuntu-restricted-addons
ins xubuntu-community-wallpapers-focal
ins xubuntu-wallpapers
ins xubuntu-community-wallpapers-trusty
ins xubuntu-docs

sudo apt install -y xfdesktop4

sudo apt install -y xfwm4

sudo apt install -y zenity

sudo apt install -y libnotify-bin

sudo apt install -y xfce4-notifyd

sudo apt install -y xfce4-appfinder

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

echo ""
echo "Installed ALL the Xfce."
echo ""

ins freedoom

ins snap
ins snapd

sudo snap install snapd

sudo snap install hello-world

sudo snap install xonotic

sudo snap install nethack

sudo snap install snap-store

sudo snap install supertux --edge

sudo snap install os-runes

sudo snap install minetest --beta

sudo snap install drawio

sudo snap install ponysay

sudo snap install languagetool

sudo snap install pngcrush --edge

sudo snap install tetris-thefenriswolf

sudo snap install skype --classic

sudo snap install canonical-livepatch
sudo apt-get install gnome-online-accounts -y
ins gnome-online-accounts

sudo snap install bobrossquotes

sudo snap install wisdom

sudo snap install fortune-cm

sudo snap install fast

sudo snap remove electronplayer

sudo snap install p7zip-desktop

sudo snap install gog-galaxy-wine

sudo snap install gnash-raymii

sudo snap install vice-jz

sudo snap install x16emu --candidate

sudo snap install veloren

sudo snap refresh

flatpak install flathub com.adobe.Flash-Player-Projector -y --noninteractive

flatpak install flathub org.gpodder.gpodder -y --noninteractive

flatpak install flathub io.freetubeapp.FreeTube -y --noninteractive

flatpak install flathub org.jitsi.jitsi-meet -y --noninteractive

flatpak install flathub com.unity.UnityHub -y --noninteractive

flatpak install flathub io.mrarm.mcpelauncher -y --noninteractive

flatpak install flathub org.srb2.SRB2 -y --noninteractive

flatpak install flathub org.srb2.SRB2Kart -y --noninteractive

flatpak install flathub net.supertuxkart.SuperTuxKart -y --noninteractive

flatpak install flathub com.zandronum.Zandronum -y --noninteractive

flatpak install flathub org.glimpse_editor.Glimpse -y --noninteractive

flatpak install flathub org.gtk.Gtk3theme.Greybird -y --noninteractive

flatpak install flathub com.eduke32.EDuke32 -y --noninteractive

flatpak install flathub net.sourceforge.fretsonfire -y --noninteractive

flatpak install flathub org.gnome.Dictionary -y --noninteractive

# flatpak gajim and plugins (no more)
flatpak remove org.gajim.Gajim -y --noninteractive
flatpak remove org.gajim.Gajim.Plugin.appindicator -y --noninteractive
flatpak remove org.gajim.Gajim.Plugin.url_image_preview -y --noninteractive
flatpak remove org.gajim.Gajim.Plugin.omemo -y --noninteractive
# ^ flatpak gajim and plugins (no more) /> 

# dino
ins curl
sudo apt update -y
sudo apt install -y dino-im
sudo apt install -y dino
sudo apt update -y
ins dino

# dino/>

flatpak install flathub org.zdoom.GZDoom -y --noninteractive

flatpak install flathub com.retrodev.blastem -y --noninteractive

flatpak install flathub ws.openarena.OpenArena -y --noninteractive

flatpak install flathub com.gitlab.coringao.cavestory-nx -y --noninteractive

flatpak install flathub com.github.shonumi.gbe-plus -y --noninteractive

flatpak install flathub de.gunibert.Hackgregator -y --noninteractive

flatpak install flathub org.DolphinEmu.dolphin-emu -y --noninteractive

flatpak install flathub org.desmume.DeSmuME -y --noninteractive

flatpak install flathub net.mancubus.SLADE -y --noninteractive

flatpak update

# appimaged
cd /opt
wget "https://github.com/AppImage/appimaged/releases/download/continuous/appimaged-x86_64.AppImage"
chmod a+x appimaged-x86_64.AppImage
./appimaged-x86_64.AppImage --install

wget https://github.com/AppImage/appimaged/releases/download/continuous/appimaged_1-alpha-git8e248f5.travis223_amd64.deb
sudo gdebi -n appimaged_1-alpha-git8e248f5.travis223_amd64.deb
systemctl --user add-wants default.target appimaged
systemctl --user start appimaged
# ^ appimaged />

# appimaged appimageupdate
wget https://github.com/AppImage/AppImageUpdate/releases/download/continuous/AppImageUpdate-x86_64.AppImage
sudo mv "/opt/AppImageUpdate-x86_64.AppImage" /usr/local/bin/AppImageUpdate
sudo chmod a+x /usr/local/bin/AppImageUpdate
# ^ appimaged appimageupdate />

# appimaged appimageupdatetool
wget https://github.com/AppImage/AppImageUpdate/releases/download/continuous/appimageupdatetool-x86_64.AppImage
sudo mv "/opt/appimageupdatetool-x86_64.AppImage" /usr/local/bin/appimageupdatetool
sudo chmod a+x /usr/local/bin/appimageupdatetool
# ^ appimaged appimageupdatetool />

sudo apt install -y nethack-console moon-buggy ninvaders nsnake pacman4console bsdgames typespeed vitetris frotz
sudo apt install -y emacs --no-install-recommends && sudo apt install -y emacs-nox

ins light-themes
ins humanity-icon-theme
sudo apt remove -y pop-gnome-shell-theme
ins pop-gtk-theme
ins pop-icon-theme
ins pop-sound-theme

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo apt install -y tasksel

insNIR gnome-software

sudo apt install -y gnome-software-plugin-flatpak

sudo apt install -y gnome-software-plugin-snap

sudo apt remove -y yaru-theme-gnome-shell

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo apt-get install -y ubuntu-wallpapers-* edgy-wallpapers feisty-wallpapers gutsy-wallpapers

cd /opt

sudo apt-get install -y build-essential linux-headers-$(uname -r)
ins virtualbox-guest-x11

sleep 4s

xrandr -s 0

sleep 1s

# yaru/communitheme
sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo snap refresh
sudo flatpak update

sudo apt remove -y yaru-theme-gnome-shell
sudo apt install -y yaru-theme-gtk
sudo apt install -y yaru-theme-icon
sudo apt install -y yaru-theme-sound
sudo apt remove -y communitheme-snap-session

sudo snap install communitheme

flatpak install flathub org.gtk.Gtk3theme.Communitheme -y --noninteractive
flatpak install flathub org.gtk.Gtk3theme.Yaru -y --noninteractive
flatpak install flathub org.gtk.Gtk3theme.Yaru-light -y --noninteractive
flatpak install flathub org.gtk.Gtk3theme.Yaru-dark -y --noninteractive

gsettings set org.gnome.shell.extensions.user-theme name "Yaru-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.desktop.wm.preferences theme "Yaru-dark"
gsettings set org.gnome.shell.extensions.user-theme name "Yaru-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru"
gsettings set  org.gnome.desktop.interface cursor-theme "Yaru"

# fix bugs
gsettings set org.gnome.shell.extensions.user-theme name "Yaru-dark" # < fix bugs


gsettings set org.gnome.desktop.sound theme-name "Yaru"
gsettings set org.gnome.desktop.sound event-sounds true

#lvnote "If the Yaru/Communitheme isn't working, you may need to install and enable this (in both Appearance and Window Manager settings, if Xfce): https://www.xfce-look.org/p/1251531/ if it wasn't already installed. You MAY just need to check the settings and enable it."

mkdir /home/$(whoami)/.themes
cd /home/$(whoami)/.themes
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/Yaru-xfce.tar.gz
tar -xzvf Yaru-xfce.tar.gz -C /home/$(whoami)/.themes
rm -rf /home/$(whoami)/.themes/Yaru-xfce.tar.gz

sudo snap refresh
sudo flatpak update

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install
# ^ yaru/communitheme />

gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM

sudo apt install -y variety

sleep 0s && nohup echo "" && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

sleep 2s

killall variety
pkill variety

ins gamemode
ins cpufrequtils
ins preload
sudo systemctl disable ondemand

lvnote "Set performance governor for maximum performance by following this; https://gitlab.com/-/snippets/1992871 "

# libstrangle git (OLD, NOW BROKEN FOR ME)
#cd /opt
#git clone https://gitlab.com/torkel104/libstrangle
#cd libstrangle
sudo apt install -y gcc-multilib
sudo apt install -y g++-multilib
sudo apt install -y libx11-dev
sudo apt install -y mesa-common-dev
sudo apt install -y build-essential
#make
#sudo make install

# disable apport
sudo systemctl disable apport.service
sudo systemctl mask apport.service
sudo systemctl stop apport
sudo apt remove -y apport
sudo rm /etc/cron.daily/apport
sudo service apport stop ; sudo sed -ibak -e s/^enabled\=1$/enabled\=0/ /etc/default/apport ; sudo mv /etc/default/apportbak ~
sudo apt purge -y apport
sudo sed -i 's/^enabled=1/enabled=0/' /etc/default/apport
# /disable apport

ins krita
ins pinta
ins gnome-calendar
ins gnome-shell-pomodoro

sudo apt remove -y gdm3

ins earlyoom
sudo systemctl enable earlyoom
sudo systemctl start earlyoom
sleep 0s && nohup earlyoom && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown && echo ""
echo ""

ins chrome-gnome-shell
#lvnote "Be sure to properly sync, install, and configure ALL of your GNOME Shell Extensions, if using GNOME."
ins x11-utils

sudo apt remove -y gnome-clocks

ins gnome-software-plugin-flatpak
ins gnome-software-plugin-snap

ins gnome-shell-extensions

ins gnome-shell-extension-ubuntu-dock
ins gnome-shell-extension-top-icons-plus

ins gnome-shell-extension-system76-power
ins gnome-shell-extension-pop-battery-icon-fix

ins gnome-shell-extension-impatience

ins gnome-shell-extension-appindicator

sudo apt remove -y gimp

ins gnome-shell-pomodoro

ins elementary-xfce-icon-theme
ins elementary-icon-theme

ins git
cd /home/$(whoami)/Documents
git clone https://github.com/strycore/gamera-manifesto
ln -s /home/$(whoami)/Documents/gamera-manifesto/index.html /home/$(whoami)/Documents/gamera-manifesto.htm

ins wget
cd /home/$(whoami)/Documents
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/advice_like-youth_probably-just-wasted-on-the-young__Mary-Schmich.odt

mkdir /home/$(whoami)/Videomaking

mkdir /home/$(whoami)/Working
mkdir /home/$(whoami)/Working/Important

brcappend "alias nh='ssh nethack@eu.hardfought.org'"
brcappend "alias nethack='ssh nethack@eu.hardfought.org'"
brcappend "alias nethack-console='ssh nethack@eu.hardfought.org'"
brcappend "alias hardfought='ssh nethack@eu.hardfought.org'"
brcappend "alias hf='ssh nethack@eu.hardfought.org'"

ins wmctrl

touch /home/$(whoami)/.xbindkeysrc
echo '"xkill"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Control + Shift + X' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys

brcappend "alias cbh='echo Fully_clearing_bash_history_then_exiting && cat /dev/null > ~/.bash_history && history -c && history -w && exit'"

ins libimage-exiftool-perl

brcappend "alias noexif='exiftool -all= $1'"

touch /home/$(whoami)/.xbindkeysrc

echo '"pavucontrol"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Pause' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys


touch /home/$(whoami)/.xbindkeysrc

echo '"null"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Control + Q' >> /home/$(whoami)/.xbindkeysrc

echo '"wmctrl -c :ACTIVE:"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Alt + F4' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys

brcappend "alias yolo='sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush'"

brcappend "gsettings set org.gnome.desktop.app-folders folder-children ['']"

touch /home/$(whoami)/.xbindkeysrc

echo '"true"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Insert' >> /home/$(whoami)/.xbindkeysrc

echo '"true"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Control + q' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys

ins skanlite

mkdir /home/$(whoami)/Applications
cd /home/$(whoami)/Applications
ins wget
wget https://github.com/simoniz0r/twitch-wrapper/releases/download/v0.0.3/twitch-wrapper-0.0.3-x86_64.AppImage
sudo chmod +x ./twitch-wrapper-0.0.3-x86_64.AppImage

mkdir /home/$(whoami)/Applications
cd /home/$(whoami)/Applications
ins wget
wget https://github.com/ppy/osu/releases/latest/download/osu.AppImage
sudo chmod +x ./osu.AppImage


touch /home/$(whoami)/.xbindkeysrc

echo '"null"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t F5' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys


touch /home/$(whoami)/.xbindkeysrc

echo '"bash -c "if wmctrl -m | grep 'mode: ON'; then exec wmctrl -k off; else exec wmctrl -k on; fi""' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Control + Alt + D' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys


flatpak install flathub org.ppsspp.PPSSPP -y --noninteractive

gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.privacy remember-app-usage false

flatpak install flathub org.mypaint.MyPaint -y --noninteractive

ins gconf2
dconf write /org/gnome/shell/overrides/attach-modal-dialogs false
gconftool-2 –set /org/gnome/shell/overrides/attach-modal-dialogs false –type bool
gsettings set org.gnome.mutter attach-modal-dialogs false
gsettings set org.gnome.shell.overrides attach-modal-dialogs false
gsettings set org.gnome.shell.extensions.classic-overrides attach-modal-dialogs false
gconftool-2 --set --type=bool /desktop/cinnamon/windows/attach_modal_dialogs false

ins gnome-shell-extension-weather

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

ins zram-config
ins zram-tools

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo apt-get install -y webcamoid*

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo apt-get purge -y gnome-2048 aisleriot atomix gnome-chess five-or-more hitori iagno gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

ins ubuntu-restricted-addons
ins ubuntu-restricted-extras

insNIR gnome-shell-extensions

ins frei0r-plugins

sudo apt -y install unrar zip unzip p7zip-full p7zip-rar rar unace sharutils uudeview mpack arj cabextract file-roller

sleep 2s

ins intel-microcode

sleep 2s

cd /opt
wget https://meltdown.ovh -O spectre-meltdown-checker.sh
chmod +x ./spectre-meltdown-checker.sh
sudo ./spectre-meltdown-checker.sh

brcappend "alias cls=clear"

brcappend "alias clr=clear"

ins fwupd

ins package-update-indicator

ins gnome-firmware

ins unattended-upgrades
ins update-notifier-common
sudo dpkg-reconfigure -plow unattended-upgrades

ins gir1.2-gmenu-3.0
ins gnome-menus
ins libgettextpo-dev
ins gettext
ins xdg-utils
ins xdg-user-dirs-gtk

ins dxvk

ins dosbox

sudo apt-get install -y mupen64plus*

# use the desmume flatpak instead, flatpak is way newer
sudo apt remove -y desmume

ins hedgewars

uppy

ins tmux

sudo apt-get install -y libvpx*
sudo apt-get install -y libvorbis*

sudo apt-get install -y libvulkan1 libvulkan1:i386 vulkan-tools


sleep 0s && nohup vkcube && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown

sleep 10s

killall vkcube
pkill vkcube

uppy

ins git
ins make
ins gcc
ins libsdl2-dev
ins libvulkan-dev
ins libvorbis-dev
ins libmad0-dev
ins libx11-xcb-dev

uppy

git clone https://github.com/neffo/bing-wallpaper-gnome-extension.git $HOME/.local/share/gnome-shell/extensions/BingWallpaper@ineffable-gmail.com

gsettings set com.ubuntu.sound allow-amplified-volume false

#xfconf-query -c xfce4-desktop -l | grep last-image | while read path; do xfconf-query -c xfce4-desktop -p $path -s /opt/ubuntenwall/ubuntenwall.png; done

# clean up opt a bit
sudo rm -rf /opt/Wire-3.19.2928_amd64.deb
sudo rm -rf /opt/phoronix-test-suite_9.8.0_all.deb
sudo rm -rf /opt/os-depends.sh
sudo rm -rf /opt/minigalaxy_0.9.4_all.deb
sudo rm -rf /opt/Geekbench-5.2.3-Linux.tar.gz
sudo rm -rf /opt/codium_1.48.0-1597345748_amd64.deb
sudo rm -rf /opt/Brackets.Release.1.14.1.64-bit.deb
sudo rm -rf /opt/benchmark-launcher-2.0.5-linux.tar.gz
sudo rm -rf /opt/appimaged_1-alpha-git8e248f5.travis223_amd64.deb

# remove temp junk
sudo rm -rf /home/$(whoami)/apportbak
sudo rm -rf /home/$(whoami)/fast.sh
sudo rm -rf /opt/Unigine_Heaven-4.0.run

# make xfce4 window buttons on the left and as i like them
xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|O"

# download profile photo
cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/face.png

ins thinkfan
ins lm-sensors
thinkfan
sudo systemctl enable thinkfan.service

ins xclip
ins xsel
mkdir /opt/clearclipboard
brcappend 'alias ccb="bash /opt/clearclipboard/ccb.sh"'
cd /opt/clearclipboard
wget https://gitlab.com/Novimatrem/clearclipboard/-/raw/master/ccb.sh
cd /opt

ins ppa-purge

uppy

sudo snap refresh

ins dkms
ins linux-headers-generic
mkdir /opt/anbox-novi
cd /opt/anbox-novi
git clone https://github.com/anbox/anbox-modules.git
cd anbox-modules
sudo ./INSTALL.sh
sudo modprobe ashmem_linux
sudo modprobe binder_linux
sudo snap install --devmode --beta anbox
ins android-tools-adb

sudo snap refresh

uppy

ins wget
ins curl
ins lzip
ins tar
ins unzip
ins squashfs-tools

uppy

sudo snap refresh

wget https://raw.githubusercontent.com/geeks-r-us/anbox-playstore-installer/master/install-playstore.sh

chmod +x ./install-playstore.sh

bash ./install-playstore.sh

uppy

sudo snap refresh

ins sauerbraten

sudo apt-get install -y plasma-discover*

ins pingus

uppy

arepo ppa:cappelikan/ppa

uppy

ins mainline

uppy

mkdir "/home/$(whoami)/EMU Roms"

ins caffeine
ins software-properties-common
ins software-properties-gtk

# !!!
# FINAL UNINSTALLS
# !!!

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo snap refresh

sudo apt remove -y xfce4-terminal
sudo apt remove -y xterm
sudo apt remove -y catfish
sudo apt remove -y xfce4-clipman
sudo apt remove -y totem
sudo apt remove -y gnome-music
sudo apt remove -y xfce4-notes
sudo apt remove -y xfburn
sudo apt remove -y gnome-todo
sudo apt remove -y thunderbird
sudo apt remove -y gnome-contacts
sudo apt remove -y evolution
sudo apt remove -y xfce4-dict
sudo apt remove -y xfce4-taskmanager
sudo apt remove -y xfce4-screenshooter
sudo apt remove -y gnome-screensaver
sudo apt remove -y xfce4-screensaver
sudo apt remove -y xscreensaver
sudo apt remove -y cool-retro-term
sudo apt remove -y gnome-terminal
sudo apt remove -y gnome-documents
sudo apt remove -y gnome-maps
sudo apt remove -y gnome-photos
sudo apt remove -y evince
sudo apt remove -y mousepad
sudo apt remove -y lxterminal

ins xscreensaver

sudo apt remove -y communitheme-snap-session
sudo apt remove -y gnome-shell
sudo apt remove -y pidgin
sudo apt remove -y pop-gnome-shell-theme
sudo apt remove -y yaru-theme-gnome-shell

sudo snap remove electronplayer

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

# !!!
# /FINAL UNINSTALLS
# !!!

# !!!
# 2021 --
# !!!

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

ins gnome-disk-utility
ins software-properties-common
ins software-properties-gtk
ins zsnes

uppy

sudo apt remove -y cinnamon
sudo apt remove -y cinnamon-desktop-environment

#
# CREATE STARTUP PROGRAM ENTRY
#
mkdir /home/$(whoami)/.config/autostart
touch /home/$(whoami)/.config/autostart/caffeine-indicator.desktop

echo "[Desktop Entry]" >> /home/$(whoami)/.config/autostart/caffeine-indicator.desktop
echo "Type=Application" >> /home/$(whoami)/.config/autostart/caffeine-indicator.desktop
echo "Name=caffeine-indicator" >> /home/$(whoami)/.config/autostart/caffeine-indicator.desktop
echo "Exec=/usr/bin/caffeine-indicator" >> /home/$(whoami)/.config/autostart/caffeine-indicator.desktop
echo "Comment=caffeine-indicator" >> /home/$(whoami)/.config/autostart/caffeine-indicator.desktop
echo "Terminal=false" >> /home/$(whoami)/.config/autostart/caffeine-indicator.desktop

echo ""
echo ""
echo "verify below:"
echo ""
ls /home/$(whoami)/.config/autostart/
echo ""
cat /home/$(whoami)/.config/autostart/caffeine-indicator.desktop
echo ""
echo "done listing"
echo ""
echo ""
#
# /END OF CREATE STARTUP PROGRAM ENTRY
#


# c64 radios in bashrc
ins dos2unix
ins wget
cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/radios.txt
dos2unix /opt/radios.txt
printf "$(cat /opt/radios.txt)" >> /home/$(whoami)/.bashrc
sleep 2s
rm -rf /opt/radios.txt
# /c64 radios in bashrc

ins gnome-screenshot

# my alarm clock

ins zenity
ins espeak
git clone https://gitlab.com/Novimatrem/alarm-clock /opt/alarm-clock
#
# CREATE STARTUP PROGRAM ENTRY
#
mkdir /home/$(whoami)/.config/autostart
touch /home/$(whoami)/.config/autostart/alarm-clock.desktop

echo "[Desktop Entry]" >> /home/$(whoami)/.config/autostart/alarm-clock.desktop
echo "Type=Application" >> /home/$(whoami)/.config/autostart/alarm-clock.desktop
echo "Name=alarm-clock" >> /home/$(whoami)/.config/autostart/alarm-clock.desktop
echo "Exec=bash /opt/alarm-clock/alarm-clock.sh" >> /home/$(whoami)/.config/autostart/alarm-clock.desktop
echo "Comment=alarm-clock" >> /home/$(whoami)/.config/autostart/alarm-clock.desktop
echo "Terminal=false" >> /home/$(whoami)/.config/autostart/alarm-clock.desktop

echo ""
echo ""
echo "verify below:"
echo ""
ls /home/$(whoami)/.config/autostart/
echo ""
cat /home/$(whoami)/.config/autostart/alarm-clock.desktop
echo ""
echo "done listing"
echo ""
echo ""
#
# /END OF CREATE STARTUP PROGRAM ENTRY
#


# /my alarm clock

# my bedtime reminder

ins zenity
ins espeak
git clone https://gitlab.com/Novimatrem/bedtime-reminder /opt/bedtime-reminder
#
# CREATE STARTUP PROGRAM ENTRY
#
mkdir /home/$(whoami)/.config/autostart
touch /home/$(whoami)/.config/autostart/bedtime-reminder.desktop

echo "[Desktop Entry]" >> /home/$(whoami)/.config/autostart/bedtime-reminder.desktop
echo "Type=Application" >> /home/$(whoami)/.config/autostart/bedtime-reminder.desktop
echo "Name=bedtime-reminder" >> /home/$(whoami)/.config/autostart/bedtime-reminder.desktop
echo "Exec=bash /opt/bedtime-reminder/bedtime-reminder.sh" >> /home/$(whoami)/.config/autostart/bedtime-reminder.desktop
echo "Comment=bedtime-reminder" >> /home/$(whoami)/.config/autostart/bedtime-reminder.desktop
echo "Terminal=false" >> /home/$(whoami)/.config/autostart/bedtime-reminder.desktop

echo ""
echo ""
echo "verify below:"
echo ""
ls /home/$(whoami)/.config/autostart/
echo ""
cat /home/$(whoami)/.config/autostart/bedtime-reminder.desktop
echo ""
echo "done listing"
echo ""
echo ""
#
# /END OF CREATE STARTUP PROGRAM ENTRY
#


# /my bedtime reminder

# my talking clock

ins zenity
ins espeak
ins libnotify-bin
git clone https://gitlab.com/Novimatrem/talking-clock /opt/talking-clock
#
# CREATE STARTUP PROGRAM ENTRY
#
mkdir /home/$(whoami)/.config/autostart
touch /home/$(whoami)/.config/autostart/talking-clock.desktop

echo "[Desktop Entry]" >> /home/$(whoami)/.config/autostart/talking-clock.desktop
echo "Type=Application" >> /home/$(whoami)/.config/autostart/talking-clock.desktop
echo "Name=talking-clock" >> /home/$(whoami)/.config/autostart/talking-clock.desktop
echo "Exec=bash /opt/talking-clock/talking-clock.sh" >> /home/$(whoami)/.config/autostart/talking-clock.desktop
echo "Comment=talking-clock" >> /home/$(whoami)/.config/autostart/talking-clock.desktop
echo "Terminal=false" >> /home/$(whoami)/.config/autostart/talking-clock.desktop

echo ""
echo ""
echo "verify below:"
echo ""
ls /home/$(whoami)/.config/autostart/
echo ""
cat /home/$(whoami)/.config/autostart/talking-clock.desktop
echo ""
echo "done listing"
echo ""
echo ""
#
# /END OF CREATE STARTUP PROGRAM ENTRY
#


# /my talking clock

# cinnamon window buttons tweak, left
ins dconf-cli
dconf write /org/cinnamon/desktop/wm/preferences/button-layout "'close,minimize,maximize:'"
# /cinnamon window buttons tweak, left

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo apt remove -y pidgin
sudo apt install -y nestopia

gsettings set org.cinnamon.desktop.wm.preferences num-workspaces 1
gsettings set org.nemo.desktop show-desktop-icons false
gsettings set org.cinnamon.theme name "cinnamon"
#dconf write /org/cinnamon/desktop/background/picture-uri "'file:///opt/ubuntenwall.png'"
dconf write /org/cinnamon/desktop/interface/clock-show-date true
gsettings set org.cinnamon.desktop.privacy remember-recent-files false
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 0
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 0

ins quadrapassel

sudo apt remove -y parole

# c64 font install
cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/C64_TrueType_v1.2.1-STYLE.zip
unzip C64_TrueType_v1.2.1-STYLE.zip
mkdir -p ~/.local/share/fonts
cd /opt/C64_TrueType_v1.2.1-STYLE
cd /opt/C64_TrueType_v1.2.1-STYLE/fonts
cp *.ttf ~/.local/share/fonts/
fc-cache -f -v

sleep 2s

rm -rf /opt/C64_TrueType_v1.2.1-STYLE
rm -rf /opt/C64_TrueType_v1.2.1-STYLE/*
cd /opt
rm -rf /opt/C64_TrueType_v1.2.1-STYLE.zip
# /c64 font install


# dos font install
cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/LessPerfectDOSVGA.ttf
mkdir -p ~/.local/share/fonts
cp *.ttf ~/.local/share/fonts/
fc-cache -f -v

sleep 2s
cd /opt
rm -rf /opt/LessPerfectDOSVGA.ttf
# /dos font install

# redshift-gtk
ins redshift-gtk
# /redshift-gtk

sudo snap install clock-signal --edge

ins fs-uae
ins fs-uae-launcher

sudo snap install telegram-desktop

ins toot

sudo snap install sengi

ins celluloid

# minecraft java
cd /opt
wget https://launcher.mojang.com/download/Minecraft.deb
insdeb /opt/Minecraft.deb
sleep 5s
rm -rf /opt/Minecraft.deb
# /minecraft java

sudo snap install spelunky

brcappend 'alias calm="play -n synth brownnoise synth pinknoise mix synth 0 0 0 10 10 40 trapezium amod 0.1 30"'

# tlp fixes
sudo systemctl enable tlp tlp-sleep
#cd /etc
#sudo rm -rf /etc/tlp.conf
#sudo wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/tlp.conf
# NO MORE TLP CONFIG FOR NOW, DEFAULT IS FINE
# /tlp fixes

sudo snap install translatium

mkdir /home/$(whoami)/.themes
cd /home/$(whoami)/.themes
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/Ambiance_2018.tar.gz
tar -xzvf Ambiance_2018.tar.gz -C /home/$(whoami)/.themes
rm -rf /home/$(whoami)/.themes/Ambiance_2018.tar.gz

cd /home/$(whoami)/Applications
rm -rf ./Cool-Retro-Term-1.1.1-x86_64.AppImage
rm -rf /home/$(whoami)/Applications/Cool-Retro-Term-1.1.1-x86_64.AppImage
cd /opt

sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
sudo youtube-dl -U

flatpak install flathub org.tuxpaint.Tuxpaint -y --noninteractive

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo apt remove -y lxde
sudo apt remove -y lxde-common
sudo apt remove -y lxde-core
sudo apt remove -y lxde-settings-daemon

sudo apt purge clipit -y
killall clipit
pkill clipit

sudo apt purge mousepad -y
killall mousepad
pkill mousepad

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

ins gnome-mines
ins kmines
ins freesweep

ins stterm

sudo apt-get purge -y awesome*

flatpak install flathub im.pidgin.Pidgin -y --noninteractive

sudo apt-get install -y openjdk-8-j*

#lvnote "Be sure to set your startup programs in awesome wm, if you're using that, following this https://askubuntu.com/questions/57264/how-can-i-define-startup-applications-with-the-awesome-window-manager"



cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/open-thunar-in-awesomewm.sh

touch /home/$(whoami)/.xbindkeysrc

echo '"bash /opt/open-thunar-in-awesomewm.sh' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Control + Alt + E' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys





cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/open-appfinder-in-awesomewm.sh

touch /home/$(whoami)/.xbindkeysrc

echo '"bash /opt/open-appfinder-in-awesomewm.sh"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Alt + F3' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys





cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/open-terminal-in-awesomewm.sh

touch /home/$(whoami)/.xbindkeysrc

echo '"bash /opt/open-terminal-in-awesomewm.sh"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Control + Alt + T' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys






cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/open-screenshot-in-awesomewm.sh

touch /home/$(whoami)/.xbindkeysrc

echo '"bash /opt/open-screenshot-in-awesomewm.sh"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Print' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys








cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/open-ff-in-awesomewm.sh

touch /home/$(whoami)/.xbindkeysrc

echo '"bash /opt/open-ff-in-awesomewm.sh"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Control + Alt + F' >> /home/$(whoami)/.xbindkeysrc

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys







ins telegram-purple

ins neofetch
ins toilet
ins figlet
ins lolcat

# specifically only st term (simple terminal, suckless)
sudo apt purge -y xfce4-terminal
sudo apt remove -y xterm
sudo apt remove -y gnome-terminal
sudo apt remove -y lxterminal
ins stterm
# specifically only st term (simple terminal, suckless)

# additional wine dependencies (WoW)
sudo dpkg --add-architecture i386

ins libgnutls30:i386
ins libldap-2.4-2:i386
ins libgpg-error0:i386
ins libxml2:i386
ins libasound2-plugins:i386
ins libsdl2-2.0-0:i386
ins libfreetype6:i386
ins libdbus-1-3:i386
ins libsqlite3-0:i386
ins msttcorefonts
# /additional wine dependencies (WoW)

# okay fine i'll use the wine ppa even though it's always fkn down
sudo dpkg --add-architecture i386 

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo dpkg --add-architecture i386 

cd /opt/

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo apt install -y --install-recommends winehq-devel

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush
# /okay fine i'll use the wine ppa even though it's always fkn down
# just in case v
ins winetricks
ins dxvk



sudo snap install scummvm


ins idle
ins idle3

ins wget
cd /opt
mkdir /opt/novi_renpy
cd /opt/novi_renpy
wget https://www.renpy.org/dl/7.4.2/renpy-7.4.2-sdk.tar.bz2
tar -xvf /opt/novi_renpy/renpy-7.4.2-sdk.tar.bz2
cd /opt/novi_renpy/renpy-7.4.2-sdk
ln -s /opt/novi_renpy/renpy-7.4.2-sdk/renpy.sh /home/$(whoami)/renpy.sh
sudo chmod +x /home/$(whoami)/renpy.sh
sudo chmod +x /opt/novi_renpy/renpy-7.4.2-sdk/renpy.sh

# set up (as much as is automatically possible) wondershaper to bandaid patch my ISP-provided-router's lack of QoS
sudo apt install -y wondershaper
ins git
cd /bin
sudo git clone https://github.com/magnific0/wondershaper.git
cd wondershaper
sudo make install
sudo systemctl enable wondershaper.service
sudo systemctl start wondershaper.service
# /set up (as much as is automatically possible) wondershaper to bandaid patch my ISP-provided-router's lack of QoS


ins ioquake3

ins iotop

sudo apt-get install -y libdvd*
sudo dpkg-reconfigure libdvd-pkg
ins libdvd-pkg
ins libdvdnav4
ins regionset

ins rbdoom3bfg


mkdir /home/$(whoami)/Applications
cd /home/$(whoami)/Applications
ins wget
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/avocado-ac399fa-x86_64.AppImage
sudo chmod +x ./avocado-ac399fa-x86_64.AppImage



mkdir /home/$(whoami)/Applications
cd /home/$(whoami)/Applications
ins wget
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/FromScratch-1.4.2-x86_64.AppImage
sudo chmod +x ./FromScratch-1.4.2-x86_64.AppImage






# my Limit PulseAudio MAX volume to 100% script, for safety
cd /opt
ins pactl
git clone https://gitlab.com/Novimatrem/limit-pulseaudio-max-volume-to-100-percent
#
# CREATE STARTUP PROGRAM ENTRY
#
mkdir /home/$(whoami)/.config/autostart
touch /home/$(whoami)/.config/autostart/limit-pulseaudio-max-volume-to-100-percent.desktop

echo "[Desktop Entry]" >> /home/$(whoami)/.config/autostart/limit-pulseaudio-max-volume-to-100-percent.desktop
echo "Type=Application" >> /home/$(whoami)/.config/autostart/limit-pulseaudio-max-volume-to-100-percent.desktop
echo "Name=limit-pulseaudio-max-volume-to-100-percent" >> /home/$(whoami)/.config/autostart/limit-pulseaudio-max-volume-to-100-percent.desktop
echo "Exec=bash /opt/limit-pulseaudio-max-volume-to-100-percent/limit-pulseaudio-max-volume-to-100-percent.sh" >> /home/$(whoami)/.config/autostart/limit-pulseaudio-max-volume-to-100-percent.desktop
echo "Comment=limit-pulseaudio-max-volume-to-100-percent" >> /home/$(whoami)/.config/autostart/limit-pulseaudio-max-volume-to-100-percent.desktop
echo "Terminal=false" >> /home/$(whoami)/.config/autostart/limit-pulseaudio-max-volume-to-100-percent.desktop

echo ""
echo ""
echo "verify below:"
echo ""
ls /home/$(whoami)/.config/autostart/
echo ""
cat /home/$(whoami)/.config/autostart/limit-pulseaudio-max-volume-to-100-percent.desktop
echo ""
echo "done listing"
echo ""
echo ""
#
# /END OF CREATE STARTUP PROGRAM ENTRY
#


# /my Limit PulseAudio MAX volume to 100% script, for safety






# my warning-sound-if-volume-is-100-percent
cd /opt
ins pactl
ins libnotify-bin
git clone https://gitlab.com/Novimatrem/warning-sound-if-volume-is-100-percent
#
# CREATE STARTUP PROGRAM ENTRY
#
mkdir /home/$(whoami)/.config/autostart
touch /home/$(whoami)/.config/autostart/warning-sound-if-volume-is-100-percent.desktop

echo "[Desktop Entry]" >> /home/$(whoami)/.config/autostart/warning-sound-if-volume-is-100-percent.desktop
echo "Type=Application" >> /home/$(whoami)/.config/autostart/warning-sound-if-volume-is-100-percent.desktop
echo "Name=warning-sound-if-volume-is-100-percent" >> /home/$(whoami)/.config/autostart/warning-sound-if-volume-is-100-percent.desktop
echo "Exec=bash /opt/warning-sound-if-volume-is-100-percent/warning-sound-if-volume-is-100-percent.sh" >> /home/$(whoami)/.config/autostart/warning-sound-if-volume-is-100-percent.desktop
echo "Comment=warning-sound-if-volume-is-100-percent" >> /home/$(whoami)/.config/autostart/warning-sound-if-volume-is-100-percent.desktop
echo "Terminal=false" >> /home/$(whoami)/.config/autostart/warning-sound-if-volume-is-100-percent.desktop

echo ""
echo ""
echo "verify below:"
echo ""
ls /home/$(whoami)/.config/autostart/
echo ""
cat /home/$(whoami)/.config/autostart/warning-sound-if-volume-is-100-percent.desktop
echo ""
echo "done listing"
echo ""
echo ""
#
# /END OF CREATE STARTUP PROGRAM ENTRY
#


# /my warning-sound-if-volume-is-100-percent


# libs for enter the gungeon
sudo dpkg --add-architecture i386
sudo apt update -y
sudo apt install -y libc6:i386 libasound2:i386 libasound2-data:i386 libasound2-plugins:i386 libstdc++6:i386 libx11-6:i386 libxau6:i386 libxcb1:i386 libxcursor1:i386 libxdmcp6:i386 libxext6:i386 libxfixes3:i386 libxinerama1:i386 libxrandr2:i386 libxrender1:i386 libsdl2-2.0-0:i386 libgl1-mesa-dev:i386

# plank
ins plank
sleep 2s
sleep 0s && nohup plank && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown && echo ""

#
# CREATE STARTUP PROGRAM ENTRY
#
mkdir /home/$(whoami)/.config/autostart
touch /home/$(whoami)/.config/autostart/planknovi.desktop

echo "[Desktop Entry]" >> /home/$(whoami)/.config/autostart/planknovi.desktop
echo "Type=Application" >> /home/$(whoami)/.config/autostart/planknovi.desktop
echo "Name=planknovi" >> /home/$(whoami)/.config/autostart/planknovi.desktop
echo "Exec=plank" >> /home/$(whoami)/.config/autostart/planknovi.desktop
echo "Comment=planknovi" >> /home/$(whoami)/.config/autostart/planknovi.desktop
echo "Terminal=false" >> /home/$(whoami)/.config/autostart/planknovi.desktop

echo ""
echo ""
echo "verify below:"
echo ""
ls /home/$(whoami)/.config/autostart/
echo ""
cat /home/$(whoami)/.config/autostart/planknovi.desktop
echo ""
echo "done listing"
echo ""
echo ""
#
# /END OF CREATE STARTUP PROGRAM ENTRY
#


sudo snap install opensurge

# Timekpr-nExT
arepo ppa:mjasnik/ppa
uppy
ins timekpr-next
# /Timekpr-nExT

ins gltron

sudo apt remove -y pcmanfm
sudo apt remove -y gpicview
sudo apt remove -y xarchiver

ins firefox

ins lynx
ins links
ins w3m
ins w3m-img
ins links
ins links2
ins elinks
ins byobu
ins tmux

flatpak install flathub org.gnome.Epiphany -y --noninteractive

sudo snap install notepadqq
sudo snap install liveforspeed
sudo snap install tmnationsforever

ins darkplaces

ins deja-dup

ins artha


mkdir /home/$(whoami)/Applications
cd /home/$(whoami)/Applications
ins wget
wget https://github.com/GitSquared/edex-ui/releases/download/v2.2.7/eDEX-UI-Linux-x86_64.AppImage
sudo chmod +x ./eDEX-UI-Linux-x86_64.AppImage

sudo snap install reicast --edge

flatpak install flathub org.flycast.Flycast -y --noninteractive

sudo snap install ffmpeg

ins ubuntu-restricted-addons
ins ubuntu-restricted-extras

ins vlc

ins libdvdnav4
ins gstreamer1.0-plugins-bad
ins gstreamer1.0-plugins-ugly


# super lock key (slk) bind and command
ins wmctrl
ins xbindkeys
cd /opt
git clone https://gitlab.com/Novimatrem/super-lock-key
brcappend "alias slk='bash /opt/super-lock-key/slk.sh'"
touch /home/$(whoami)/.xbindkeysrc
echo '"bash /opt/super-lock-key/slk.sh"' >> /home/$(whoami)/.xbindkeysrc
echo -e ' \t Scroll_Lock' >> /home/$(whoami)/.xbindkeysrc
xbindkeys_autostart
killall xbindkeys
pkill xbindkeys
xbindkeys
# /super lock key (slk) bind and command

brcappend "echo 'Type slk to lock the system.'"

mkdir /home/$(whoami)/.icons

ins wget
cd /opt
#wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/ubuntenwall_sl_10-6.png
#gsettings set org.gnome.desktop.background picture-uri file:///opt/ubuntenwall_sl_10-6.png
cd /opt
#mkdir ubuntenwall_sl_10-6
#cd /opt/ubuntenwall_sl_10-6
#wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/ubuntenwall_sl_10-6.png

#xfconf-query -c xfce4-desktop -l | grep last-image | while read path; do xfconf-query -c xfce4-desktop -p $path -s /opt/ubuntenwall_sl_10-6/ubuntenwall_sl_10-6.png; done

#dconf write /org/cinnamon/desktop/background/picture-uri "'file:///opt/ubuntenwall_sl_10-6.png'"

flatpak install flathub com.bitwarden.desktop -y --noninteractive

# NoteBot (by adolfintel / fdossena) install+autorun
ins wget
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

# awoo time in bashrc

brcappend 'echo ""'
brcappend 'echo "awoo~"'
brcappend 'TZ=Australia/NSW date'
brcappend 'echo ""'

# /awoo time in bashrc

flatpak install flathub im.riot.Riot -y --noninteractive

# w95 electron
cd /opt
wget https://github.com/felixrieseberg/windows95/releases/download/v2.3.0/windows95_2.3.0_amd64.deb
insdeb ./windows95_2.3.0_amd64.deb
sudo rm -rf /opt/windows95_2.3.0_amd64.deb

# />

# w98 electron
cd /opt
wget https://github.com/liudonghua123/windows98/releases/download/v2.2.0/windows98_2.2.0_amd64.deb
insdeb ./windows98_2.2.0_amd64.deb
sudo rm -rf /opt/windows98_2.2.0_amd64.deb
# />

flatpak install flathub com.dosbox_x.DOSBox-X -y --noninteractive

ins vlc-plugin-fluidsynth

cd /opt/
wget https://launcher.technicpack.net/launcher4/643/TechnicLauncher.jar

mkdir /home/$(whoami)/Flashes

flatpak install flathub io.github.Hexchat -y --noninteractive

ins quodlibet

ins language-pack-gnome-en

sudo rm -rf /opt/README.txt
sudo rm -rf /opt/notebot-1.6-bin.7z

ins xcalib

mkdir /home/$(whoami)/Applications
cd /home/$(whoami)/Applications
ins wget
wget https://www.mudlet.org/download/Mudlet-4.12.0-linux-x64.AppImage.tar
tar -xf /home/$(whoami)/Applications/Mudlet-4.12.0-linux-x64.AppImage.tar
sudo chmod +x ./Mudlet.AppImage
sudo rm -rf /home/$(whoami)/Applications/Mudlet-4.12.0-linux-x64.AppImage.tar

sudo snap install dm-tools

sudo snap install melonds

# download profile photo 2
cd /home/$(whoami)/Pictures
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/face.png

sudo snap install runelite --edge

# ipod shuffle stuff
sudo apt-get install -y libimobiledevice*
sudo apt-get install -y ifuse
sudo apt-get install -y libgpod*
sudo apt-get install -y gtkpod
sudo apt-get install -y rhythmbox
sudo apt-get install -y clementine
# /ipod shuffle stuff

# bsd stuff

sudo apt install -y bsdextrautils

sudo apt install -y bsdgames

sudo apt install -y bsdgames-nonfree

sudo apt install -y bsdutils

sudo snap install killbots

# /bsd stuff

ins ratpoison

ins mc

ins remmina

sudo apt install -y git p7zip-full python3-pip python3-wxgtk4.0
sudo pip3 install WoeUSB-ng

# auto set profile photo in some cirumstances
cd /home/$(whoami)
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/.face.png
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/.face

pip install termtime

flatpak install flathub com.rafaelmardojai.Blanket -y --noninteractive

# protontricks
sudo apt install -y python3-pip python3-setuptools python3-venv pipx

pipx install protontricks

pipx upgrade protontricks
# /protontricks

ins smartmontools

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo apt-get purge -y awesome*
sudo apt remove -y lxde
sudo apt remove -y lxde-common
sudo apt remove -y lxde-core
sudo apt remove -y lxde-settings-daemon
sudo apt remove -y openbox

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo apt remove -y pop-desktop
sudo apt autoremove -y --purge --allow-remove-essential pop-desktop
sudo apt remove -y pop-desktop --allow-remove-essential

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush









sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo apt-get purge -y --allow-remove-essential awesome*
sudo apt remove -y --allow-remove-essential lxde
sudo apt remove -y --allow-remove-essential lxde-common
sudo apt remove -y --allow-remove-essential lxde-core
sudo apt remove -y --allow-remove-essential lxde-settings-daemon
sudo apt remove -y --allow-remove-essential openbox

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo apt remove -y --allow-remove-essential pop-desktop
sudo apt autoremove -y --purge --allow-remove-essential pop-desktop
sudo apt remove -y pop-desktop --allow-remove-essential

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush



ins qt5-style-plugins



# win95 wall
#ins wget
#cd /opt
#wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/95wall.png
#mkdir 95wall
#cd /opt/95wall
#wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/95wall.png
#xfconf-query -c xfce4-desktop -l | grep last-image | while read path; do xfconf-query -c xfce4-desktop -p $path -s /opt/95wall/95wall.png; done
#dconf write /org/cinnamon/desktop/background/picture-uri "'file:///opt/95wall.png'"
#gsettings set org.gnome.desktop.background picture-uri file:///opt/95wall.png
# /win95 wall


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

xfconf-query -c xfwm4 -p /general/use_compositing -s false

sudo snap remove powershell


# best wall
ins wget
cd /opt
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/80s_Disco_Dingo_Simulation_by_Abubakar_NK.jpg
mkdir 80s_Disco_Dingo_Simulation_by_Abubakar_NK
cd /opt/80s_Disco_Dingo_Simulation_by_Abubakar_NK
wget https://gitlab.com/Novimatrem/personal-autosetup-linux-ubuntu/-/raw/master/80s_Disco_Dingo_Simulation_by_Abubakar_NK.jpg
xfconf-query -c xfce4-desktop -l | grep last-image | while read path; do xfconf-query -c xfce4-desktop -p $path -s /opt/80s_Disco_Dingo_Simulation_by_Abubakar_NK/80s_Disco_Dingo_Simulation_by_Abubakar_NK.jpg; done
dconf write /org/cinnamon/desktop/background/picture-uri "'file:///opt/80s_Disco_Dingo_Simulation_by_Abubakar_NK.jpg'"
gsettings set org.gnome.desktop.background picture-uri file:///opt/80s_Disco_Dingo_Simulation_by_Abubakar_NK.jpg
# /best wall

sudo snap install clouds

flatpak install flathub org.gnome.Boxes -y --noninteractive

echo " 
alias psn=\"st -- sh -c 'htop' & st -- sh -c 'sudo iotop' & st -- sh -c 'watch -n 0.1 nvidia-smi'\"
 " >> /home/$(whoami)/.bashrc

sudo snap install trello-desktop

sudo apt install -y libjpeg62*
sudo apt install -y libjpeg62
sudo apt install -y libjpeg62-dev

ins compton
xfconf-query -c xfwm4 -p /general/use_compositing -s false

lvnote "Be sure to set your keyboard shortcuts and bindings exactly how you want them, else you forget and it drives you mad."

mkdir /home/$(whoami)/Pictures/Wallpapers

cd /home/$(whoami)/Downloads
wget https://freealarmclocksoftware.com/FreeAlarmClockSetup.exe

insNIR kwrite

flatpak install flathub org.zdoom.GZDoom

flatpak install flathub com.thebrokenrail.MCPIReborn
# https://flathub.org/apps/details/com.thebrokenrail.MCPIReborn

# !!!
# FINAL STEPS
# !!!
sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

uppy
sleep 0s && nohup appimaged && rm -rf $HOME/nohup.out && rm -rf $(pwd)/nohup.out && rm -rf /opt/nohup.out && disown & disown && echo ""

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

rm -rf /opt/nohup.out
rm -rf $HOME/nohup.out
rm -rf $(pwd)/nohup.out

uppy

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install && flatpak update -y --noninteractive && sudo flatpak update -y --noninteractive && flatpak uninstall --unused && sudo snap refresh && sudo journalctl --flush && sudo journalctl --rotate && sudo journalctl --vacuum-time=1s && sudo journalctl --vacuum-size=200M && sudo journalctl --flush

sudo apt purge -y xfce4-terminal
sudo apt remove -y lxterminal
brcappend "tmux && clear"
brcappend "clear"
brcappend "alias exit='wmctrl -c :ACTIVE:'"

brcappend "echo 'Drink coffee. Have 1 coffee per day.'"

brcappend "echo ''"
brcappend "echo 'Perhaps you could go outside? Do some outside hobby?'"
brcappend "echo ''"
brcappend "echo 'Maybe you could go out for a walk for 45 minutes?'"
brcappend "echo ''"

uppy

xbindkeys_autostart

killall xbindkeys
pkill xbindkeys

xbindkeys

sudo snap refresh
sudo flatpak update

sudo apt remove -y lxterminal

sudo update-alternatives --all
sudo update-alternatives --config editor

sudo dpkg --configure -a && sudo apt-get -f install && sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean -y && sudo dpkg --configure -a && sudo apt-get -f install

sudo echo -e "\n Novimatrem personal-autosetup-linux installed by $(whoami) at $(date) - do not remove this file, it's for safety to not accidentally re-apply changes. This is MILESTONE 7. \n" >> /opt/novisetup.done

touch /opt/MILESTONE_7
sudo touch /opt/MILESTONE_7

lvnote "Finished executing Novimatrem personal-autosetup-linux Ubuntu at around $(date)"

rm -rf /home/$(whoami)/fast.sh
rm -rf /home/$(whoami)/Desktop/fast.sh
sudo chown $USER /opt/
sudo chown $USER /opt/*
rm -rf /opt/nohup.out
sudo rm -rf /opt/nohup.out

gtfo

# />
