#!/bin/sh

echo "Installing yay"
mkdir ~/git-clones
cd ~/git-clones
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si
echo "yay installation complete!"
cd ..
rm -rf yay 
sleep 3
echo "Updating yay databases"
yay -Syu 

# Remove these lines or change them if you wish to 
echo "Making sure git is configured"
git config --global user.email "aamodj23@gmail.com"
git config --global user.name "AamodJ"
git config --global credential.helper store
echo "Git configured"

cd dotfiles 

echo "Installing dependencies"
yay -S --noconfirm bspwm sxhkd polybar kitty dunst neofetch lf rclone rofi rofi-calc rofi-emoji gotop nsxiv pandoc-bin vundle bat feh obs-studio pipewire-pulse udisks2 simple-mtpfs zathura zathura-djvu zathura-pdf-mupdf spaceship-prompt-git picom-ibhagwan-git zsh-syntax-highlighting fzf man cpupower-gui scrot firefox betterlockscreen pipewire-jack pipewire-alsa qjackctl autocutsel cronie wireguard-tools msr-tools xf86-input-synaptics gimp libreoffice-still nautilus adb scrcpy compsize ani-cli texlive-core texlive-bin texlive-latexextra texlive-bibtexextra xf86-input-wacom brillo volnoti xdg-ninja tdrop-git spicetify-cli colorpicker jamesdsp upscayl-bin wshowkeys-git x86_energy_perf_policy betterdiscord-installer-bin sc-im

echo "Installing wayland related packages"
yay -S --noconfirm hyprland waybar-hyprland-git hyprpicker-git hyprpaper-git swaync wlogout slurp grim xorg-xwayland-hidpi-xprop catppuccin-gtk-theme-macchiato playerctl qt6-wayland swaylock-effects-git swayidle zscroll-git

echo "Copying configs"
cp -r .config/* ~/.config/
mkdir ~/.dotfiles
cp -r .dotfiles/* ~/.dotfiles
mkdir -p ~/.local
cp -r .local/* ~/.local/
chown root ~/.local/sbin/
chown root ~/.local/sbin/*
mkdir ~/.config/z
sudo cp ~/.config/trackpad/70-synaptics.conf /etc/X11/xorg.conf.d/
echo "Fixing ani-cli"
sudo cp ~/.config/ani-cli-fix/* /usr/bin/
echo "ani-cli fixed!"

# In sxhkdrc, scrot saves the screenshots to ~/Pictures/Screenshots, so we need to create the Screenshots folder 
mkdir ~/Pictures/Screenshots

echo "Configured!"
sleep 3

# Remove this part if you wish to use another system backup tool (like snapper)
echo "Installing timeshift"
cd ~/git-clones
git clone https://aur.archlinux.org/timeshift.git
cd timeshift
makepkg -si
echo "Timeshift installed!"
cd .. 
rm -rf timeshift

# 2018 Macbook Pro specific things. Remove if irrelavent for your device
echo "Fixing audio"
sudo git clone https://github.com/kekrby/t2-better-audio.git /tmp/t2-better-audio
cd /tmp/t2-better-audio
./install.sh
sudo rm -r /tmp/t2-better-audio
cd ~/git-clones
sleep 3
echo "Fixing fan"
git clone https://github.com/networkException/mbpfan
cd mbpfan
make
sudo make tests
sudo make install
sudo cp mbpfan.service /etc/systemd/system/
sudo systemctl enable mbpfan.service
sudo systemctl daemon-reload
sudo systemctl start mbpfan.service
cd ..
rm -rf mbpfan
echo "Fan Fixed!"
sleep 3
echo "Fixing suspend"
sudo cp ~/.config/suspend/rmmod_tb.sh /lib/systemd/system-sleep/rmmod_tb.sh
sudo chmod 755 /lib/systemd/system-sleep/rmmod_tb.sh
sudo chown root:root /lib/systemd/system-sleep/rmmod_tb.sh
echo "Suspend fixed!"

sleep 3
echo "Installation complete. For changes to take effect, reboot."
echo "Installing zsh and making it default shell"
yay -S --noconfirm zsh 
chsh -s /usr/bin/zsh
