FROM ubuntu:24.04

# Update and install sudo
RUN apt-get update && apt-get install -y sudo nix direnv

# Allow ubuntu user to use sudo without password
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /etc/nix && \
    echo "trusted-users = root ubuntu " | tee -a /etc/nix/nix.conf && \
    echo "max-jobs = auto" | tee -a /etc/nix/nix.conf && \
    echo "experimental-features = nix-command flakes" | tee -a /etc/nix/nix.conf


RUN chown -R ubuntu:ubuntu /nix

# Set ubuntu as the default user
USER ubuntu

WORKDIR /home/ubuntu

# Install Nix and devenv system-wide
ENV PATH="/home/ubuntu/.local/state/nix/profiles/profile/bin/:$PATH"
# RUN nix profile install --accept-flake-config "nixpkgs#devenv"
# RUN echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
