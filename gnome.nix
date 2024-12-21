{ config, pkgs, ... }:

{
  services = {
    xserver = {
      displayManager.gdm = {
        enable = true;
        wayland = false;
      };
      desktopManager.gnome.enable = true;
    };
    gnome = {
      core-utilities.enable = false;
      gnome-keyring.enable = true;
    };
    gvfs.enable = true;
  };

  qt.platformTheme = "gnome";
  programs.seahorse.enable = true;

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-backgrounds
      gnome-online-accounts
      gnome-remote-desktop
      gnome-tour
      gnome-user-docs
    ];
    systemPackages = with pkgs; [
      baobab
      eog
      evince
      file-roller
      gnome-calculator
      gnome-console
      gnome-control-center
      gnome-disk-utility
      gnome-system-monitor
      gnome-text-editor
      gnome-tweaks
      nautilus
      pinentry-gnome3
      qgnomeplatform
      seahorse
      gnomeExtensions.appindicator
      gnomeExtensions.removable-drive-menu
    ];
  };
}
