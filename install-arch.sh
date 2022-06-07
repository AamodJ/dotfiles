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
yay -S --noconfirm bspwm sxhkd polybar kitty dunst neofetch lf rclone rofi gotop nsxiv pandoc-bin vundle bat feh obs-studio pipewire-pulse udisks2 simple-mtpfs zathura zathura-djvu zathura-pdf-mupdf mbpfan spaceship-prompt-git picom-ibhagwan-git brightnessctl zsh-syntax-highlighting fzf man cpupower-gui scrot firefox betterlockscreen pipewire-jack pipewire-alsa qjackctl autocutsel cronie 

echo "Copying configs"
cp -r .config/* ~/.config/
mkdir ~/.dotfiles
cp -r .dotfiles/* ~/.dotfiles
mkdir -p ~/.local
cp -r .local/* ~/.local/
cp .Xresources ~/.Xresources
cp .xinitrc ~/.xinitrc 
cp .zprofile ~/.zprofile 
cp .zshenv ~/.zshenv
cd ~/.dotfiles/dmenu 
makepkg -si
mkdir ~/.config/z
touch ~/.config/z/.z

# In sxhkdrc, scrot saves the screenshots to ~/Pictures/Screenshots, so we need to create the Screenshots folder 
mkdir ~/Pictures/Screenshots

echo "Configured!"
sleep 3

# Remove this part if you wish to use another system backup tool (eg. snapper)
echo "Installing timeshift"
cd ~/git-clones
git clone https://aur.archlinux.org/timeshift.git
cd timeshift
makepkg -si
echo "Timeshift installed!"
cd .. 
rm -rf timeshift

# 2018 Macbook Pro specific things. Remove if irrelavent for your machine
echo "Fixing audio"
sudo cp ~/.config/audio/AppleT2.conf /usr/share/alsa/cards/AppleT2.conf
sudo cp ~/.config/audio/apple-t2.conf /usr/share/alsa-card-profile/mixer/profile-sets/apple-t2.conf
sudo cp ~/.config/audio/91-pulseaudio-custom.rules /usr/lib/udev/rules.d/91-pulseaudio-custom.rules
echo "Audio fixed!"
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
echo "Installation complete. For changes to take effect, reboot."
echo "Installing zsh and making it default shell"
yay -S --noconfirm zsh 
chsh -s /usr/bin/zsh
