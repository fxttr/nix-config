{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    {
      device = "rpool/local/root";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/B4FE-552F";
      fsType = "vfat";
      options = [ "fmask=002" "dmask=002" ];
    };

  fileSystems."/nix" =
    {
      device = "rpool/local/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    {
      device = "rpool/safe/home";
      fsType = "zfs";
    };

  fileSystems."/persist" =
    {
      device = "rpool/safe/persist";
      fsType = "zfs";
    };

  fileSystems."/mnt/minio" =
    {
      device = "/dev/disk/by-uuid/1c16bcb4-ec80-4a6f-99f0-d1c9f57311e6";
      fsType = "xfs";
      options = [ "nofail" "users" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/e265876b-a241-40c6-993a-d97f565b21b2"; }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = false;
    graphics.enable = true;
  };
}
