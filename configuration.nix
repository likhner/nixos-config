{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/common/cpu/intel/kaby-lake/default.nix>
      <nixos-hardware/common/pc/ssd/default.nix>
      ./hardware-configuration.nix
      ./software.nix
      ./gnome.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  system.autoUpgrade.enable = true;
  time.timeZone = "Europe/Riga";

  networking = {
    hostName = "likhner-pc";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = false;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "lv_LV.utf8";
      LC_IDENTIFICATION = "lv_LV.utf8";
      LC_MEASUREMENT = "lv_LV.utf8";
      LC_MONETARY = "lv_LV.utf8";
      LC_NAME = "lv_LV.utf8";
      LC_NUMERIC = "lv_LV.utf8";
      LC_PAPER = "lv_LV.utf8";
      LC_TELEPHONE = "lv_LV.utf8";
      LC_TIME = "lv_LV.utf8";
    };
  };

  sound.enable = true;
  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = [ "nvidia" ];
      screenSection = ''
        Option "CustomEDID" "HDMI-0:/home/likhner/.local/share/EDID.bin"
      '';
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      config.pipewire = {
        "context.properties" = {
          "default.clock.allowed-rates" = [ 44100 48000 96000 192000 ];
          "default.clock.quantum-limit" = 1024;
          "default.clock.max-quantum" = 1024;
        };
      };
    };
    ntp.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    pulseaudio.enable = false;
  };

  users.users.likhner = {
    isNormalUser = true;
    home = "/home/likhner";
    extraGroups = [ "wheel" "networkmanager" "nvidia" "vboxusers" "docker" ];
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 8d";
    };
    settings.auto-optimise-store = true;
  };

  environment.variables = {
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_PATH = "/tmp";
  };

  system.stateVersion = "22.05";
}
