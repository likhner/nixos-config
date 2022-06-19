{ config, pkgs, ... }:

{
  imports =
    [
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

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = [ "nvidia" ];
      exportConfiguration = true;
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
    opengl.enable = true;
    pulseaudio.enable = false;
    cpu.intel.updateMicrocode = true;
  };

  users.users.likhner = {
    isNormalUser = true;
    home = "/home/likhner";
    extraGroups = [ "wheel" "networkmanager" "nvidia" "vboxusers" "docker" ];
  };

  nix.autoOptimiseStore = true;

  environment.variables = {
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_PATH = "/tmp";
  };

  system.stateVersion = "22.05";
}
