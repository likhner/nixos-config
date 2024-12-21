{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in {
  nixpkgs.config.allowUnfree = true;

  programs = {
    steam.enable = true;
    gnupg.agent.enable = true;
    _1password-gui = {
      enable = true;
      package = unstable.pkgs._1password-gui;
    };
  };

  environment.systemPackages = with pkgs; [
    aspellDicts.en
    aspellDicts.ru
    aspellDicts.lv
    bash-completion
    bind
    exfat
    f2fs-tools
    git
    gnupg
    unstable.google-chrome
    helvum
    mc
    nettools
    openssh
    p7zip
    unstable.prismlauncher
    unstable.tdesktop
    unrar
    unzip
    vlc
    wget
    whois
    wireguard-tools
    (unstable.vscode-with-extensions.override {
      vscodeExtensions = with unstable.vscode-extensions; [
        ms-azuretools.vscode-docker
        github.codespaces
        github.copilot
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
