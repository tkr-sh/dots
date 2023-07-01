FROM fedora:latest

# Copy dotfiles
COPY dots /root/dots
COPY install.sh /root

# Update package manager and install Git and Zsh
RUN dnf -y update && \
    dnf -y install git

# Go to root directory
WORKDIR /root

# Create a .config if it doesnt exists
RUN mkdir -p .config

# Install additional packages
RUN echo "y" | ./install.sh all


CMD ["/bin/zsh"]
