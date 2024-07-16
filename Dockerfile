FROM ubuntu:24.04

ENV PATH="$PATH:/root/.nix-profile/bin/"
RUN apt-get update && apt-get install -y nix direnv && \
rm -rf /var/cache/apt/archives /var/lib/apt/lists/* && \
mkdir -p /etc/nix && \
echo "trusted-users = root " | tee -a /etc/nix/nix.conf && \
echo "max-jobs = auto" | tee -a /etc/nix/nix.conf && \
echo "experimental-features = nix-command flakes" | tee -a /etc/nix/nix.conf
