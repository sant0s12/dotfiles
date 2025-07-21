{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = [
    "kvm-amd"
  ];

  boot.kernelParams = [
    "systemd.restore_state=0"
    "amdgpu.dcdebugmask=0x40000"
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ ];

  boot.initrd.systemd.enable = true;

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/4948429d-6f96-4cf9-8d98-95d0b2e18d36";

  fileSystems."/mnt/btrfs" = {
    device = "/dev/disk/by-uuid/048ec34d-87b3-4247-80fc-e880ae0f8cba";
    fsType = "btrfs";
    options = [
      "subvol=/"
      "noatime"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/048ec34d-87b3-4247-80fc-e880ae0f8cba";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/048ec34d-87b3-4247-80fc-e880ae0f8cba";
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/048ec34d-87b3-4247-80fc-e880ae0f8cba";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/048ec34d-87b3-4247-80fc-e880ae0f8cba";
    fsType = "btrfs";
    options = [
      "subvol=log"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/048ec34d-87b3-4247-80fc-e880ae0f8cba";
    fsType = "btrfs";
    options = [
      "subvol=swap"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FDEE-9CA7";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 32 * 1024;
    }
  ];

  hardware.bluetooth.enable = true;
  hardware.acpilight.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
