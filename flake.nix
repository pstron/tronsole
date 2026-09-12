{
  description = "tronsole - a reusable NixOS configuration template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    nvchad-config = {
      url = "path:./assets/neovim";
      flake = false;
    };

    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvchad-config";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      treefmt-nix,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
      ];

      forEachSystem = nixpkgs.lib.genAttrs systems;

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      treefmtModule =
        {
          pkgs,
          ...
        }:
        {
          projectRootFile = "flake.nix";

          programs.nixfmt = {
            enable = true;
            package = pkgs.nixfmt;
          };
        };

      treefmtEval = forEachSystem (system: treefmt-nix.lib.evalModule (mkPkgs system) treefmtModule);

      mkHost =
        hostName:
        let
          host = import ./hosts/${hostName}/variables.nix;
          system = host.system;
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs host;
          };

          modules = [
            ./hosts/${hostName}

            inputs.catppuccin.nixosModules.catppuccin
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.home-manager.nixosModules.home-manager
          ];
        };
    in
    {
      # NixOS hosts
      nixosConfigurations = {
        CHANGE-ME = mkHost "CHANGE-ME";
      };

      # Development environment
      devShells = forEachSystem (
        system:
        let
          pkgs = mkPkgs system;
          treefmt = treefmtEval.${system}.config.build.wrapper;
        in
        {
          default = pkgs.mkShellNoCC {
            name = "tronsole-dev";

            packages = with pkgs; [
              # Nix language / formatting.
              nixd
              nixfmt
              treefmt

              # Static analysis / maintenance.
              deadnix
              statix

              # NixOS workflow.
              nh
              nvd
              nix-tree

              # Repository tooling.
              git
              ripgrep
              jq
            ];

            shellHook = ''
              printf '\n'
              printf 'tronsole development shell\n'
              printf '  nix fmt                 Format the repository\n'
              printf '  nix flake check         Evaluate hosts and checks\n'
              printf '  deadnix .               Find unused Nix bindings\n'
              printf '  statix check .          Find common Nix antipatterns\n'
              printf '\n'
            '';
          };
        }
      );

      formatter = forEachSystem (system: treefmtEval.${system}.config.build.wrapper);

      checks = forEachSystem (
        system:
        let
          treefmt = treefmtEval.${system};
        in
        {
          formatting = treefmt.config.build.check self;
        }
      );
    };
}
