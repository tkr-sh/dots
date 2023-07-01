FROM ubuntu:latest

COPY dots /root/dots
COPY install.sh /root

# Update packman 
RUN apt -y update
RUN apt -y install git

# Go in root
WORKDIR /root

# Install packages
RUN echo "y" | ./install.sh all

CMD ["/bin/zsh"]
