{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.elixir
            pkgs.inotify-tools
            (
              with pkgs.dotnetCorePackages;
                combinePackages [
                  # The SDK includes `runtime` as well as `aspnetcore`.
                  sdk_10_0
                ]
            )
          ];
          shellHook = ''
            dotnet tool restore
          '';
        };
      }
    );
}
