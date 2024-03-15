{...}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = age: final: prev: {
    factorio = prev.factorio.override {
      username = "sant0s12";
      token = age.secrets.factorio-token.path;
    };
  };
}
