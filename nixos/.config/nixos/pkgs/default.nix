{pkgs, ...}: {
  systemd-inhibit-wait = pkgs.callPackage ./systemd-inhibit-wait.nix {};
}
