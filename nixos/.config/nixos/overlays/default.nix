{ outputs, inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    # Funny linux bug
    ghostty = prev.ghostty.overrideAttrs (_: {
      preBuild = ''
        shopt -s globstar
        sed -i 's/^const xev = @import("xev");$/const xev = @import("xev").Epoll;/' **/*.zig
        shopt -u globstar
      '';
    });
    # hyprland = inputs.hyprland.packages.${prev.system}.hyprland.overrideAttrs (old: {
    #   debug = true;
    #   patches =
    #     (old.patches or [])
    #     ++ [
    #       ./hyprland-patch.txt
    #     ];
    # });
  };
}
