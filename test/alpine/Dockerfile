FROM alpine:latest

# Copy dotfiles
COPY dots /root/dots
COPY install.sh /root

# Update package manager and install git
RUN apk update && \
    apk add --no-cache git bash

# Go to root directory
WORKDIR /root

# Create a .config if it doesnt exists
RUN mkdir -p .config

# Install additional packages
RUN echo "y" | ./install.sh all


CMD ["/bin/zsh"]

