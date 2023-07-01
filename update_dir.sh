#!/usr/bin/zsh

# Files and directories
dirs=("nvim" "i3" "polybar" "rofi" "alacritty" "picom" "neofetch")
files=("$HOME/.zshrc")


# Go in the correct directory
# And if this directory exists, remove its content
cd dots && rm -rf *

# Copy every directory
for dir in "${dirs[@]}" ; do
    cp -r "$HOME/.config/$dir" "."
done

# Copy every file
for file in "${files[@]}"; do
    cp "$file" "."
done

# Remove useless files
find . -type d -name ".git" -exec rm -rf {} +
rm -rf nvim/plugin
rm -rf nvim/icons
