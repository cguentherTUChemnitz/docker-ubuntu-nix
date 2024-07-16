FROM ubuntu:24.04

# Update and install sudo
RUN apt-get update && apt-get install -y sudo curl xz-utils

# Allow ubuntu user to use sudo without password
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /etc/nix && \
    echo "trusted-users = root ubuntu " | tee -a /etc/nix/nix.conf && \
    echo "max-jobs = auto" | tee -a /etc/nix/nix.conf && \
    echo "experimental-features = nix-command flakes" | tee -a /etc/nix/nix.conf

# Set ubuntu as the default user
USER ubuntu

WORKDIR /home/ubuntu

# Install Nix
RUN curl -L https://nixos.org/nix/install | sh

# Set up Nix environment
ENV PATH="/home/ubuntu/.nix-profile/bin:${PATH}"
ENV NIX_PATH="/home/ubuntu/.nix-defexpr/channels"

# Source Nix profile in shell
RUN echo '. /home/ubuntu/.nix-profile/etc/profile.d/nix.sh' >> /home/ubuntu/.bashrc

RUN nix profile install --accept-flake-config nixpkgs#devenv

ENV PATH="/home/ubuntu/direnv_installation:${PATH}"
RUN mkdir -p "/home/ubuntu/direnv_installation" && bin_path="/home/ubuntu/direnv_installation" curl -sfL https://direnv.net/install.sh | bash
RUN echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
