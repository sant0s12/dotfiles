{
  outputs,
  inputs,
  ...
}: {
  additions = final: _prev:
    import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    hyprland = inputs.hyprland.packages.${prev.system}.hyprland.overrideAttrs (old: {
      debug = true;
      patches =
        (old.patches or [])
        ++ [
          ./hyprland-patch.txt
        ];
    });
  };
}
