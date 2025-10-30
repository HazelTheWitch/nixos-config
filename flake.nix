{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = inputs @ { flake-parts, import-tree, home-manager, disko, ... }: flake-parts.lib.mkFlake { inherit inputs; } (top: {
    imports = [
      home-manager.flakeModules.home-manager
      flake-parts.flakeModules.modules
      disko.flakeModules.default
      (import-tree ./modules)
    ];

    systems = [ "x86_64-linux" ];
  });
}
