{
  description = "Pixelpact Project Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    playwright.url = "github:pietdevries94/playwright-web-flake/1.46.1";
  };

  outputs = {
    playwright,
    nixpkgs,
    ...
  }: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs ["x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux"]
      (system:
        function (let
          overlay = final: prev: {
            inherit (playwright.packages.${system}) playwright-test playwright-driver;
          };
        in
          import nixpkgs {
            inherit system;
            overlays = [overlay];
          }));
  in {
    devShells = forAllSystems (
      pkgs: {
        default = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [nodejs];
          shellHook = ''
            export REPOSITORY_ROOT=$(pwd)
            export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
            export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS
          '';
        };
      }
    );

    formatter = forAllSystems (pkgs: pkgs.alejandra);
  };
}
