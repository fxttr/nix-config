# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/76bb198c-9c62-46d3-9f3e-be52e8daf149";
      fsType = "xfs";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/6610936c-d0b2-4205-a028-6433445ef6c0";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/3D9C-5E0A";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    pulseaudio.enable = false;
    bluetooth.enable = false;

    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        vulkan-validation-layers
      ];
    };
  };
}
