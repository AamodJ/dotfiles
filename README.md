# dotfiles
My current Arch setup running wayland using Hyprland. I currently run 2 setups. 
1. Wayland (using Hyprland)
2. X11 (using bspwm)

Optionally I have KDE installed too, but it's rarely used. 

## Configs
Here you'll find configs for:
1. Wayland
    1. Window manager: Hyprland stuff (`hyprland`, `hyprpaper` and `hyprpicker`)
    2. Status bar: `waybar`
    3. Notification client: `swaync`
    4. Logout menu: `wlogout`
    5. Lockscreen: `swaylock-effects-git`
    6. Idle manager: `swayidle`
    7. Theme: `catppuccin macchiato`
    8. Miscellaneous things to make the setup work (such as custom scripts in `.local/bin`, `.local/sbin` and `.local/scripts`)
2. X11
    1. bspwm 
    2. sxhkd
    4. dunst
    8. polybar
    10. dmenu

Along with the setups, there's common configs for:
1. Terminal: `kitty`
2. Text editor: `nvim`
3. File manager: `lf`
4. Fetch: `neofetch`
5. Shell: `zsh`

This X11 rice is mostly copied from [GuardKenzie's rice](https://github.com/GuardKenzie/kastali) (the original [reddit post](https://www.reddit.com/r/unixporn/comments/oaupqd/bspwm_tokyo_night/)). 

**Note:** The wayland setup uses `xdg-desktop-portal-hyprland`. 

## Install
To install this setup, you can just clone the repo and run the install script 
```
git clone https://github.com/AamodJ/dotfiles
cd dotfiles
chmod +x install-arch.sh
sh install-arch.sh
```

Note that this installation currently assumes that you're cloning the repo in a dedicated `~/git-clones` directory. Also note that there are a number of things the install script does that is specific to fixing a few things on the 2018 macbook pro (4x thunderbolt ports). If you wish to install this rice on another machine, simply remove the mac specific lines from the install script. Cheers!
