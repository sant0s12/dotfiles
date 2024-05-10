{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "rebuild";

  # Based on https://github.com/0atman/noboilerplate/blob/main/scripts/38-nixos.md#dont-use-nix-env
  text = ''
    pushd "$NIXOS_CONFIG_DIR" > /dev/null
    nix fmt &> /dev/null
    find . -name '*.nix' | git diff -U0

    echo "Rebuilding NixOS..."

    sudo nixos-rebuild switch "$@" --flake .

    IFS=" " read -r -a gen <<< "$(nixos-rebuild list-generations --flake . | grep current)"
    generation="''${gen[0]}"
    extra="''${gen[2]} ''${gen[3]} ''${gen[4]} ''${gen[5]}"

    echo "Rebuilt NixOS generation $generation $extra"
    git commit -am "NixOS gen. $generation - $extra"
    popd > /dev/null
  '';
}
