{ pkgs, config, inputs, lib, ... }:
{
  sops = {
    age = {
      keyFile = "/persist/home/marrero/.config/sops/age/keys.txt";
      generateKey = true;
    };
  };

  modules = {
    zsh.enable = true;
    theme.enable = true;
    librewolf.enable = true;

    irssi = {
      enable = true;
      user = "fxttr";
    };

    sway = {
      enable = true;
      wallpaper = "${inputs.media}/wallpaper/38c3.jpg";
    };

    waybar = {
      enable = true;
      mobile = true;
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    vscode.enable = true;
    
    ssh = {
      enable = true;
      hashKnownHosts = true;

      matchBlocks = {
        "github" = {
          hostname = "github.com";
          user = "git";
          identityFile = config.sops.secrets.ssh.path;
        };

        "codeberg" = {
          hostname = "codeberg.org";
          user = "git";
          identityFile = config.sops.secrets.ssh.path;
        };

        "workstation" = {
          hostname = "192.168.0.200";
          user = "marrero";
          identityFile = config.sops.secrets.ssh.path;
        };

        "lab0" = {
          hostname = "192.168.0.201";
          user = "marrero";
          identityFile = config.sops.secrets.ssh.path;
        };

        "rpi" = {
          hostname = "192.168.0.202";
          user = "marrero";
          identityFile = config.sops.secrets.ssh.path;
        };
      };
    };

    git = {
      enable = true;
      userName = "Florian Marrero Liestmann";
      userEmail = "f.m.liestmann@fx-ttr.de";
      ignores = [
        ".direnv/"
        ".cache/"
      ];
      
      extraConfig = {
        core = {
          editor = "vim";
          whitespace = "-trailing-space";
        };
        log = {
          abbrevCommit = true;
        };
        pull = {
          rebase = false;
        };
      };

      signing = {
        signByDefault = false;
        key = "D1912EEBC3FBEBB4";
      };
    };
  };

  home.packages = (with pkgs; [
    signal-desktop
    dbeaver-bin
    spotify
  ]);
}
