FROM gentoo/stage3:latest


# Copy dotfiles
COPY dots /root/dots
COPY install.sh /root

# Update portage tree and install Git
RUN emerge --sync && \
    emerge --noreplace dev-vcs/git

# Go to root directory
WORKDIR /root

# Create .config dir if it doesn't exists
RUN mkdir -p .config

# Install additional packages
RUN echo "y" | ./install.sh all

# Change shell
RUN chsh -s /bin/zsh


CMD ["/bin/zsh"]
