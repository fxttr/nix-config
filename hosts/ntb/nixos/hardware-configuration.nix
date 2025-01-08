{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];


  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/fa7cdd71-467c-4876-ab35-f5173e0035fe";
      fsType = "xfs";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/c86dc399-c2dd-4c6a-aad2-c80297386d6d";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/2360-9BD9";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  zramSwap.enable = true;

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = false;

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vulkan-validation-layers
      ];
    };
  };
}
