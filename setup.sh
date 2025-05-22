#!/bin/bash

os=$(uname)
programs_min="git nvim tmux emacs python ffmpeg gcc kitty lua fastfetch grep fd fzf stow man-db ripgrep python-pip vim"
programs_full="firefox octave gvim"
wm_programs="i3 picom ly rofi feh"

if [ "$os" = "Linux" ]; then
    echo "This is a linux machine"

    if [[ -f /etc/redhat-release ]]; then
        pkg_manager="sudo yum install -y"

    elif [[ -f /etc/debian_version ]]; then
        pkg_manager="sudo apt install -y"
    
    elif [[ -f /etc/arch-release ]]; then
        pkg_manager="sudo pacman -S --noconfirm"
    
    else
        echo "unsupported linux distro"
        exit 1
    fi

elif [ "$os" = "Darwin"]; then
    echo "This is a mac machine"
    pkg_manager="brew install";

else
    echo "unsupported os"
    exit 1

fi

read -p "do you want to install the full suite of programs (y) or just the min install (n)" program_choice
read -p "Do you want to install the wm programs (y) or not (n)" wm_choice

case "$program_choice" in
    y|Y)
        echo "installing the full suite of programs"
        echo "$programs_min $programs_full"
        $pkg_manager $programs_min $programs_full
        ;;
    n|N)
        echo "installing the min suite of programs"
        echo "$programs_min"
        $pkg_manager $programs_min
        ;;
esac

case "$wm_choice" in
    y|Y)
        echo "installing the wm programs"
        echo "$wm_programs"
        $pkg_manager $wm_programs
        ;;
    n|N)
        echo "passing on the install of the wm programs"
        ;;
esac

# doom emacs install
# 1. Clone Doom Emacs into ~/.config/emacs
if [ ! -d "$HOME/.config/emacs" ]; then
    echo "Cloning Doom Emacs..."
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
else
    echo "Doom Emacs already exists."
fi

# 2. Symlink your Doom config using Stow
# Assumes your custom config is in ./doom.d relative to script (e.g. dotfiles/doom.d)
echo "Linking custom Doom config (~/.doom.d) with stow..."
stow --target="$HOME" doom  

# 3. Run Doom install (will auto-detect your config)
echo "Installing Doom Emacs..."
~/.config/emacs/bin/doom install --force --no-config  # avoids using their templates

# 4. Sync to ensure all packages are fetched
~/.config/emacs/bin/doom sync

# 5. (Optional) byte-compile to speed up load time
~/.config/emacs/bin/doom build

# the rest of the symlinks w/ gnu stow
echo "Creating symlinks for dotfiles using gnu stow"
stow *

fastfetch 
echo "set up complete, enjoy your distro"


