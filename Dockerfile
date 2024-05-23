FROM ubuntu:24.04

ENV PATH="$PATH:/root/.nix-profile/bin/"
RUN apt-get update && apt-get install -y nix direnv && \
rm -rf /var/cache/apt/archives /var/lib/apt/lists/* && \
echo "experimental-features = nix-command flakes" >>/etc/nix/nix.conf && \
nix-env -iA devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable
