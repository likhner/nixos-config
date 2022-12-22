{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/common/pc/ssd/default.nix>
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
    };
  };

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
      ];
      driSupport32Bit = true;
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

  system = {
    stateVersion = "22.11";
    autoUpgrade.enable = true;
  };
}
