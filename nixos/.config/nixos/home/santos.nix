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
    btop
    bat
    gimp
    jq
    kitty
    trash-cli
    hexchat
    ladybird
    loupe
    rebuild
    discord
    davinci-resolve
    android-studio
    tldr
    wdisplays
    k9s
    waybar
    python3
    stow
    sipctl
    xdragon
    unzip
    inkscape
    networkmanagerapplet
    libreoffice
    ffmpeg
    kdenlive
    killall
    playerctl
    zathura
    evince
    atool
    inotify-tools
    swaybg
    tor-browser
    segger-jlink
    signal-desktop
    ferdium
    udiskie
    kubectl
    kubernetes-helm
    owncloud-client
    mpv
    gammastep
    file
    dunst
    ripgrep
    capitaine-cursors
    rofi-wayland
    libinput-gestures
    jellyfin-media-player
    neofetch
    lf
    ctpv
    swayosd
    pavucontrol
    grim
    slurp
    spotify
    wtype
    thunderbird
    wl-clipboard
    fluxcd
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
