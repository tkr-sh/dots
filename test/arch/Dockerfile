FROM archlinux:latest

COPY dots /root/dots
COPY install.sh /root

# Update packman 
RUN pacman -Syu --noconfirm
RUN pacman -S git --noconfirm

# Go in root
WORKDIR /root

# Create a .config if it doesnt exists
RUN mkdir -p .config

# Install packages
RUN echo "y" | ./install.sh all

# Change of shell
RUN chsh -s /bin/zsh

CMD ["/bin/zsh"]
