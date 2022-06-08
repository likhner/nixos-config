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
  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    baobab
    evince
    gnome-console
    gnome-text-editor
    qgnomeplatform
    gnome.eog
    gnome.file-roller
    gnome.gnome-calculator
    gnome.gnome-control-center
    gnome.gnome-disk-utility
    gnome.gnome-system-monitor
    gnome.gnome-tweaks
    gnome.nautilus
    gnome.seahorse
    gnomeExtensions.appindicator
    gnomeExtensions.places-status-indicator
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.sound-output-device-chooser
  ];
}
