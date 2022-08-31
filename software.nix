{ config, pkgs, ... }:

let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { config = config.nixpkgs.config; };
in {
  hardware = {
    opengl.driSupport32Bit = true;
    steam-hardware.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    steam.enable = true;
    gnupg.agent.enable = true;
  };

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
    nettools
    nmap
    openssh
    p7zip
    poedit
    rustdesk
    unstable.polymc
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
      vscodeExtensions = with vscode-extensions; [
        ms-azuretools.vscode-docker
        github.copilot
        eamodio.gitlens
        davidlday.languagetool-linter
        yzhang.markdown-all-in-one
        davidanson.vscode-markdownlint
        bbenoist.nix
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "codespaces";
          publisher = "GitHub";
          version = "1.10.4";
          sha256 = "1ngjyyvr6cvn4ffvk8d8qrfjhvbci44j7lbak7zffllnrz7zf16b";
        }
        {
          name = "vscode-nginx";
          publisher = "william-voyek";
          version = "0.7.2";
          sha256 = "0s4akrhdmrf8qwn6vp8kc31k5hx2k2wml5mcashfc09hxiqsf2cq";
        }
      ];
    })
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
