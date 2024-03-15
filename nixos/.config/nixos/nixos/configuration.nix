{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    outputs.nixosModules.borgbackup
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 32;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "acedia";
  time.timeZone = "Europe/Zurich";

  nixpkgs = {
    overlays = [outputs.overlays.additions];
    config = {
      allowUnfree = true;
      joypixels.acceptLicense = true;
    };
  };

  nix = {
    optimise.automatic = true;
    settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
  };

  services.xserver.xkb.extraLayouts.ch-qwerty = {
    description = "Swiss German QWERTY Layout";
    languages = ["de"];
    symbolsFile = builtins.fetchurl {
      url = "https://gist.githubusercontent.com/sant0s12/\
              9506659fbb86cbb25419a7856e0cf5a2/raw/\
              9176a9e655beffb50247027c09761a40dc5e34b8/ch-qwerty";
      sha256 = "39a84dc8f1bde46bff21929b97e8f8da5ad10b4853257c468ca464f452c4500b";
    };
  };

  services.xserver.enable = false;
  services.xserver.xkb.layout = "ch-qwerty";
  services.xserver.xkb.options = "caps:swapescape";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  networking.networkmanager.enable = true;

  location.provider = "geoclue2";

  services.logind.lidSwitch = "suspend-then-hibernate";

  # Services
  services.upower.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  services.geoclue2.appConfig = {
    gammastep = {
      isAllowed = true;
      isSystem = false;
    };
  };

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    #settings.PermitRootLogin = "yes";
  };

  # gnome keyring
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.direnv.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security.pam.services.swaylock = {};

  security.sudo = {
    package = pkgs.sudo.override {withInsults = true;};

    extraRules = [
      {
        groups = ["wheel"];
        commands = [
          {
            command = "${config.system.path}/bin/nixos-rebuild";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };

  users.users.santos = {
    isNormalUser = true;
    extraGroups = ["wheel" "input" "video"];
  };

  # Secrets
  age.secrets.borgpass.file = ../secrets/borgpass.age;

  services.borgbackup.jobs."home-var-etc" = {
    paths = [
      "/var/lib"
      "/home"
      "/etc/NetworkManager"
      "/etc/ssh"
    ];

    exclude = [
      # very large paths
      "/var/lib/docker"
      "/var/lib/systemd"
      "/var/lib/libvirt"

      # temporary files created by cargo and `go build`
      "**/target"
      "/home/*/go/bin"
      "/home/*/go/pkg"
      "*.pyc"
      "/home/*/.cache"
      "*/.vim*.tmp"
      "*.tmp"
      "*cache*"
      ".mozilla"
      ".rustup"
      "*/Downloads"
      "*.cargo"
    ];

    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
      monthly = -1; # Keep at least one archive for each month
    };

    repo = "ssh://admin@pi.lan.santos.party/media/hdd0/backups/acedia";

    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.age.secrets.borgpass.path}";
    };

    environment = {BORG_RSH = "ssh -i /etc/ssh/ssh_host_ed25519_key";};
    extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
    compression = "auto,zstd";
    startAt = "daily";
    inhibitsSleep = true;
    extraUnitConfig = {
      ConditionACPower = true;
      After = "network-online.target";
    };
    extraTimerConfig = {WakeSystem = true;};
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    polkit_gnome
    gnome.gnome-keyring
    inputs.agenix.packages.${system}.default
    inputs.alejandra.defaultPackage.${system}
    systemd-inhibit-wait
  ];

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerdfonts
      inconsolata
      comic-mono
      joypixels
      ubuntu_font_family
      fira
      inter
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["Fira Sans"];
      };
    };
  };

  # Do not change this
  system.stateVersion = "23.11"; # Did you read the comment?
}
