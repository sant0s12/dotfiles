{ pkgs, ... }:
{
  systemd-inhibit-wait = pkgs.callPackage ./systemd-inhibit-wait.nix { };
  rebuild = pkgs.callPackage ./rebuild.nix { };
  banshee = pkgs.callPackage ./banshee { };
}
