{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in {
  nixpkgs.config.allowUnfree = true;
  services.tailscale.enable = true;

  programs = {
    steam.enable = true;
    gnupg.agent.enable = true;
  };

  environment.systemPackages = with pkgs; [
    unstable._1password-gui
    unstable.amass
    aspellDicts.ru
    bash-completion
    bind
    exfat
    f2fs-tools
    git
    gnupg
    unstable.google-chrome
    helvum
    keepassxc
    mc
    nettools
    openssh
    p7zip
    poedit
    unstable.prismlauncher
    remmina
    spotify
    steam
    steam-run-native
    unstable.tdesktop
    transmission-gtk
    unrar
    unzip
    vlc
    wget
    whois
    (unstable.vscode-with-extensions.override {
      vscodeExtensions = with unstable.vscode-extensions; [
        ms-azuretools.vscode-docker
        github.codespaces
        github.copilot
        eamodio.gitlens
        davidlday.languagetool-linter
        yzhang.markdown-all-in-one
        davidanson.vscode-markdownlint
        bbenoist.nix
      ];
    })
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
}
