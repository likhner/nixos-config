{ config, pkgs, ... }:

{
  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    gnome = {
      core-utilities.enable = false;
      gnome-keyring.enable = true;
    };
    gvfs.enable = true;
  };

  qt5.platformTheme = "gnome";

  environment.systemPackages = with pkgs; [
    baobab
    evince
    qgnomeplatform
    gnome.eog
    gnome.file-roller
    gnome.gedit
    gnome.nautilus
    gnome.networkmanagerapplet
    gnome.seahorse
    gnome.gnome-calculator
    gnome.gnome-control-center
    gnome.gnome-disk-utility
    gnome.gnome-screenshot
    gnome.gnome-system-monitor
    gnome.gnome-terminal
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.places-status-indicator
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.sound-output-device-chooser
  ];
}
