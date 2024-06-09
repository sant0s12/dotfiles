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
    loupe
    rebuild
    discord
    android-studio
    tldr
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
    killall
    playerctl
    zathura
    atool
    inotify-tools
    swaybg
    tor-browser
    signal-desktop
    ferdium
    udiskie
    kubectl
    kubernetes-helm
    owncloud-client
    mpv
    gammastep
    file
    swayidle
    swaylock
    hyprlock
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
    openlens
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
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
      package = pkgs.gnome.adwaita-icon-theme;
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
