{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in {
  hardware = {
    opengl.driSupport32Bit = true;
    steam-hardware.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    unstable._1password-gui
    appimage-run
    aspellDicts.ru
    bash-completion
    bind
    exfat
    f2fs-tools
    ffmpeg
    git
    gnupg
    unstable.google-chrome
    keepassxc
    mc
    minecraft
    nettools
    nmap
    openssh
    p7zip
    poedit
    remmina
    spotify
    steam
    steam-run-native
    unstable.tdesktop
    transmission-gtk
    unrar
    unzip
    vlc
    unstable.vscode
    wget
    whois
  ];

  virtualisation = {
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };
}
