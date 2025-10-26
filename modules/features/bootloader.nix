{ ... }:

{
  flake.modules.nixos.bootloader = {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
