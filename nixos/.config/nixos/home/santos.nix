{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "santos";
  home.homeDirectory = "/home/santos";

  home.packages = with pkgs; [
    btop
    bat
    jq
    kitty
    nodejs
    trash-cli
    waybar
    cargo
    stow
    go
    python3
    networkmanagerapplet
    firefox
    killall
    playerctl
    zathura
    atool
    inotify-tools
    swaybg
    signal-desktop
    ferdium
    udiskie
    owncloud-client
    gammastep
    swayidle
    swaylock
    hyprlock
    dunst
    capitaine-cursors
    rofi-wayland
    libinput-gestures
    jellyfin-media-player
    neofetch
    lf
    swayosd
    pavucontrol
    grim
    slurp
    spotify
    wtype
    thunderbird
    wl-clipboard
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  qt = {
    enable = true;

    platformTheme = "gtk";

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
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
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
