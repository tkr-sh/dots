#!/bin/bash

# Prompt for yes/no confirmation
confirm() {
    local prompt="${1:-}"
    local default="${2:-N}"
    local response

    while true; do
        read -rp "$prompt" response
        response=${response,,}  # Convert response to lowercase

        if [[ -z $response ]]; then
            response=$default
        fi

        case $response in
            y|yes)
                echo "1" && return 1  # Return success (confirmed)
                ;;
            n|no)
                echo "0" && return 0  # Return failure (not confirmed)
                ;;
            *)
                echo "Invalid response. Please enter y/yes or n/no."
                ;;
        esac
    done
}


# Software
dirs=("nvim" "i3" "polybar" "rofi" "alacritty" "picom" "neofetch")
files=(".zshrc")

# The list of packages managers
pkgsm=("apt" "dnf" "pacman" "zypper" "emerge" "slackpkg" "xbps-install" "nix" "brew" "apk")
pkg_manager=""

# Arguments
args=("$@")


get_cmd() {
    case $1 in
        "apt")
            echo "apt-get install -y $2"
            apt-get install -y "$2"
            ;;
        "dnf")
            echo "dnf install -y $2"
            dnf install -y "$2"
            ;;
        "pacman")
            echo "pacman -S $2"
            pacman -S --noconfirm "$2"
            ;;
        "zypper")
            echo "zypper --non-interactive install -n $2"
            zypper --non-interactive install -n "$2"
            ;;
        "emerge")
            echo "emerge $2"
            emerge "$2"
            ;;
        "slackpkg")
            echo "slackpkg install $2"
            slackpkg install "$2"
            ;;
        "xbps-install")
            echo "xbps-install -Sy $2"
            xbps-install -Sy "$2"
            ;;
        "nix")
            echo "nix-env -iA nixpkgs.$2"
            nix-env -iA nixpkgs."$2"
            ;;
        "apk")
            echo "apk add $2"
            apk add "$2"
            ;;
        *)
            echo "Unable to determine package manager."
            ;;
    esac
}



# Get the answer of the user
tmp=$(confirm 'Do you want to install the dependencies ? [y/N] ' 'n')

if [[ $tmp == "1" ]]; then

    # Verify the package managers
    for pkgm in "${pkgsm[@]}"; do
        if command -v "$pkgm" >/dev/null 2>&1; then
            pkg_manager="$pkgm"
        fi 
    done

    # List of all packages needed
    pkgs=("i3" "neovim" "polybar" "rofi" "alacritty" "picom" "zsh" "neofetch")




    # Install packages
    for pkg in "${pkgs[@]}"; do

        # If the user want to install that package
        if [[ ${args[*]} =~ $pkg || "$1" == "all" ]]; then 
            get_cmd "$pkg_manager" "$pkg"

            # Install zsh-autosuggestions
            if [[ $pkg == "zsh" ]]; then
                git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
            fi

            # Install packer
            if [[ $pkg == "neovim" ]]; then
                git clone --depth 1 https://github.com/wbthomason/packer.nvim\
                    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
            fi

            # Install fonts
            if [[ $pkg == "neofetch" ]]; then 
               git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
                cd nerd-fonts
                ./install.sh JetBrainsMono
                cd -
            fi
        fi
    done

fi




# If we need to install all of them
if [[ "$1" == "all" ]]; then
    echo "Installing everything..."

    # Directories 
    for dir in "${dirs[@]}"; do
        cp -r "dots/$dir" "$HOME/.config/"
    done

    # Files
    for file in "${files[@]}"; do
        cp "dots/$file" "$HOME"
    done

    exit 0
else 

    echo "Installing: $(printf ",%s" "${args[@]}")"

    # Directories 
    for dir in "${dirs[@]}"; do
        if [[ ${args[*]} =~ $dir ]]; then
            cp -r "dots/$dir" "$HOME/.config/"
        fi
    done

    # Files
    for file in "${files[@]}"; do
        if [[ ${args[*]} =~ $file ]]; then
            cp "dots/$file" "$HOME"
        fi
    done

    exit 0
fi
