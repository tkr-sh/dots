FROM voidlinux/voidlinux:latest

# Update the package repository and install Git
RUN xbps-install -Syu xbps
RUN xbps-install -Sy git bash

# Copy dotfiles and installation script
COPY dots /root/dots
COPY install.sh /root

# Go to root directory
WORKDIR /root

# Create the .config if it doesnt existz
RUN mkdir -p .config

# Install packages using the installation script
RUN ls && echo "y" | /root/install.sh all

# Change the default shell to Zsh
RUN chsh -s /bin/zsh

CMD ["/bin/zsh"]

