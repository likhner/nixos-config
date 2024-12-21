{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/common/pc/ssd/default.nix>
      <nixos-hardware/common/cpu/intel/kaby-lake/cpu-only.nix>
      <nixos-hardware/common/gpu/nvidia/pascal/default.nix>
      ./hardware-configuration.nix
      ./software.nix
      ./gnome.nix
      ./home.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "lv_LV.UTF-8";
      LC_IDENTIFICATION = "lv_LV.UTF-8";
      LC_MEASUREMENT = "lv_LV.UTF-8";
      LC_MONETARY = "lv_LV.UTF-8";
      LC_NAME = "lv_LV.UTF-8";
      LC_NUMERIC = "lv_LV.UTF-8";
      LC_PAPER = "lv_LV.UTF-8";
      LC_TELEPHONE = "lv_LV.UTF-8";
      LC_TIME = "lv_LV.UTF-8";
    };
  };

  time.timeZone = "Europe/Riga";

  networking = {
    hostName = "likhner-pc";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = false;
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };

  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      screenSection = ''
        Option "CustomEDID" "HDMI-0:/home/likhner/.local/share/EDID.bin"
      '';
      excludePackages = with pkgs; [
        xterm
      ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    ntp.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
      ];
      extraPackages32 = with pkgs; [
        vaapiVdpau
      ];
    };
    pulseaudio.enable = false;
  };

  users.users.likhner = {
    isNormalUser = true;
    home = "/home/likhner";
    extraGroups = [ "wheel" "networkmanager" "nvidia" "docker" ];
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 8d";
    };
    settings.auto-optimise-store = true;
  };

  # workaround nixpkgs#169245
  environment.sessionVariables.LIBVA_DRIVER_NAME = "vdpau";

  system.stateVersion = "24.11";
}
