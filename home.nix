{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.likhner = {
    programs = {
      git = {
        enable = true;
        lfs.enable = true;
        userEmail = "60031799+likhner@users.noreply.github.com";
        userName = "Arthur Likhner";
        signing = {
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILSve0s4fmuuVAdHfDhDjvt22gZuTMTDo8rdmMcQaan";
          signByDefault = true;
        };
        aliases = {
          br = "branch";
          ls = "ls-files";
          coa = "!git add -A && git commit -m";
        };
        extraConfig = {
          color.ui = "auto";
          credential.helper = "store";
          pull.rebase = "true";
          gpg.format = "ssh";
          diff.tool = "vscode";
          "difftool \"vscode\"".cmd = "code --wait --diff $LOCAL $REMOTE";
          merge.tool = "vscode";
          "mergetool \"vscode\"".cmd = "code --wait $MERGED";
          core = {
            autocrlf = "input";
            editor = "code --wait";
          };
        };
      };
      ssh = {
        enable = true;
        matchBlocks = {
          "cartman" = {
            hostname = "100.126.49.4";
            user = "ubuntu";
          };
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "/home/likhner/.ssh/github";
            extraOptions = {
              PreferredAuthentications = "publickey";
            };
          };
        };
      };
      bash = {
        enable = true;
        shellAliases = {
          share = ''function _e(){ curl -F "expires=24" -F "file=@$1" https://0x0.st; };_e'';
          short = ''function _e(){ curl -F "url=$1" https://shorta.link; };_e'';
        };
      };
    };
    dconf.settings = {
      "org/gnome/mutter" = {
        check-alive-timeout = 60000;
      };
    };
    home = {
      file = {
        edid = {
          target = ".local/share/EDID.bin";
          source = pkgs.fetchurl {
            url = "https://gist.github.com/likhner/096845ee722cad653b87469885645ff5/raw/EDID.bin";
            sha256 = "0dkl0znrjpk7xp321s7h929a8gksl40d2vy7r49jsd9n605h6zl4";
            name = "EDID.bin";
          };
        };
        vscode = {
          target = ".config/Code/User/settings.json";
          text = ''
            {
              "workbench.colorTheme": "Monokai Dimmed",
              "workbench.iconTheme": "vs-minimal",
              "files.autoSave": "afterDelay",
              "editor.wordWrap": "on",
              "files.eol": "\n",
              "update.showReleaseNotes": false,
              "workbench.startupEditor": "none",
              "editor.inlineSuggest.enabled": true,
              "git.enableSmartCommit": true,
              "git.autofetch": true,
              "editor.tabSize": 2,
              "languageToolLinter.serviceType": "public"
            }
          '';
        };
      };
      stateVersion = "22.11";
    };
  };
}
