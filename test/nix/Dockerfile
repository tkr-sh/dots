FROM nixos/nix:latest

# Copy dotfiles
COPY dots /root/dots
COPY install.sh /root

# Update Nix channels
RUN nix-channel --update
RUN nix-env -iA nixpkgs.bash
RUN ln -s /root/.nix-profile/bin/bash /bin/bash

# Go to root directory
WORKDIR /root

# Move dotfiles to .config
RUN mkdir .config

# Install packages
RUN echo "y" | ./install.sh all
RUN ln -s /root/.nix-profile/bin/zsh /bin/zsh

CMD ["/bin/zsh"]

