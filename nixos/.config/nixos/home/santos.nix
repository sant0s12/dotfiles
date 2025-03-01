{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "santos";
  home.homeDirectory = "/home/santos";

  home.packages = with pkgs; [
    vlc
    acpilight
    android-studio
    atool
    bat
    btop
    capitaine-cursors
    ctpv
    davinci-resolve
    discord
    dunst
    evince
    ferdium
    ffmpeg
    file
    fluxcd
    gammastep
    ghostscript
    gimp
    grim
    hexchat
    imagemagick
    inkscape
    inotify-tools
    jellyfin-media-player
    jq
    k9s
    kdePackages.kdenlive
    killall
    kitty
    kubectl
    kubernetes-helm
    ladybird
    lf
    libinput-gestures
    libreoffice
    loupe
    mpv
    neofetch
    networkmanagerapplet
    nrfconnect
    owncloud-client
    pavucontrol
    playerctl
    python3
    rebuild
    ripgrep
    rofi-wayland
    segger-jlink
    signal-desktop
    slurp
    sparrow
    spotify
    stow
    swaybg
    swayosd
    syncthing
    thunderbird
    tldr
    trash-cli
    udiskie
    unzip
    waybar
    wdisplays
    wl-clipboard
    wtype
    xdragon
    youtube-music
    zathura
    zoom-us
    zotero
  ];

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "lockscreen";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "xbacklight -get > /tmp/backlight.bak && xbacklight -set 1";
          on-resume = "xbacklight -set $(cat /tmp/backlight.bak)";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl hybrid-sleep";
        }
      ];
    };
  };

  services.batsignal = {
    enable = true;
    extraArgs = [
      "-e"
      "-p"
    ];
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  xdg = {
    mimeApps = {
      enable = true;

      defaultApplications = {
        "application/pdf" = [ "org.gnome.Evince.desktop" ];
        "image/png" = [ "org.gnome.Loupe.desktop" ];
        "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
        "image/gif" = [ "org.gnome.Loupe.desktop" ];
        "image/bmp" = [ "org.gnome.Loupe.desktop" ];
        "image/svg+xml" = [
          "org.gnome.Loupe.desktop"
          "org.inkscape.Inkscape.desktop"
        ];
        "inode/directory" = [ "lf.desktop" ];
      };
    };

    configFile."mimeapps.list".force = true;
  };

  qt = {
    enable = true;

    platformTheme.name = "gtk";

    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  # Do not change
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
