{ ... }:

{
  flake.modules.nixos.nvidia = { config, ... }: {
    nixpkgs.config.allowUnfree = true;
    hardware.graphics.enable = true;
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
