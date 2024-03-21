{pkgs, ...}:
pkgs.writeShellApplication {
  name = "rebuild";

  # Based on https://github.com/0atman/noboilerplate/blob/main/scripts/38-nixos.md#dont-use-nix-env
  text = ''
    set -e
    pushd "''$NIXOS_CONFIG_DIR"
    nix fmt &> /dev/null
    git diff -U0 ./*.nix

    # shellcheck disable=SC2024
    sudo nixos-rebuild switch --flake . &> nixos-switch.log ||
      (grep --color error < nixos-switch.log) && false

    gen=$(nixos-rebuild list-generations | grep current)
    git commit -am "$gen"
    popd
  '';
}
