FROM opensuse/leap:latest

# Copy dotfiles
COPY dots /root/dots
COPY install.sh /root

# Update package manager and install Git
RUN zypper --non-interactive update && \
    zypper --non-interactive install git 

# Go to root directory
WORKDIR /root

# Move dotfiles to .config
RUN mkdir .config

# Install additional packages
RUN echo "y" | ./install.sh all

# Change shell
RUN chsh -s /bin/zsh

CMD ["/bin/zsh"]

