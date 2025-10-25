{ ... }:

{
  flake.modules.nixos.bootloader = {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        useOSProber = false;
        efiSupport = true;
        device = "nodev";
      };
    };
  };
}
