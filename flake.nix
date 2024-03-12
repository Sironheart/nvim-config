{
  description = "This is my nvim flake, which gets installed via nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        lib = import ./lib {inherit inputs;};
      };

      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.alejandra;

        packages = {
          default = pkgs.vimUtils.buildVimPlugin {
            name = "sironheart-nvim";
            postInstall = ''
              rm -rf $out/README.md
              rm -rf $out/flake.lock
              rm -rf $out/flake.nix
              rm -rf $out/.editorconfig
            '';
            src = ./.;
          };
        };
      };
    };
}
