{
  description = "dsal-c";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        name = "dsal-c";
        src = ./.;
        pkgs = nixpkgs.legacyPackages.${system};
        # buildInputs = with pkgs; [clang-tools];
        nativeBuildInputs = with pkgs; [clang-tools glibc];
      in {
        packages = {
          default = let
            inherit (pkgs) clangStdenv;
          in
            clangStdenv.mkDerivation {
              name = "dsal-c";
              src = pkgs.lib.cleanSource ./.;
              # buildInputs = with pkgs; [];

              buildPhase = with pkgs; ''
                clang ./src/main.c -o dsal-c
              '';

              installPhase = ''
                mkdir -p $out/bin
                cp dsal-c $out/bin/dsal-c
              '';
            };
        };

        devShells.default = pkgs.mkShell.override {stdenv = pkgs.clangStdenv;} {
          packages = with pkgs; [pkg-config clang-tools glibc alejandra pre-commit];
          inputsFrom = [self.packages.${system}.default];
          # buildInputs = [
          #   pkgs.alejandra
          #   pkgs.gcc
          #   pkgs.gnumake
          #   pkgs.pkg-config
          #   pkgs.llvmPackages_19.clang-tools
          #   pkgs.pre-commit
          #   # pkgs.gdb
          #   # pkgs.valgrind
          # ];

          shellHook = with pkgs; ''
            # Source .bashrc
            . .bashrc
          '';
        };
      }
    );
}
