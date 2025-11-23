{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "rebuild";

  # Based on https://github.com/0atman/noboilerplate/blob/main/scripts/38-nixos.md#dont-use-nix-env
  text = ''
        pushd "$NH_FLAKE"
        nix fmt
        find . -name '*.nix' | git diff -U0

    	clear
        echo -ne "\033[?1049h\033[2J\033[H" # enter alt-buff and clear
        echo "Rebuilding NixOS..."

        nh os switch --update "$@"

        gen=$(nixos-rebuild list-generations --json | jq '.[] | select (.current == true) | "\(.generation) - \(.date) \(.nixosVersion) \(.kernelVersion)"')

        echo -ne "\033[2J\033[?1049l" # exit alt-buff
        echo "Rebuilt NixOS generation $gen"
        git commit -am "NixOS gen. $gen"
        popd
  '';
}
