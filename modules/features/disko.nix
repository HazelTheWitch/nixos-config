{ inputs, ... }:

{
  flake.modules.nixos.disko = { lib, config, ... }:
  let cfg = config.my.disko; in {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    options = {
      my.disko.devices = {
        main = lib.mkOption { type = lib.types.str; };
      };
    };

    config = let
      btrfsopts = [
        "compress=zstd"
        "ssd"
      ];
    in {
      disko.devices.disk = {
        main = {
          type = "disk";
          device = cfg.devices.main;
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                name = "ESP";
                start = "1M";
                end = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = btrfsopts;
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = btrfsopts;
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = btrfsopts;
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
