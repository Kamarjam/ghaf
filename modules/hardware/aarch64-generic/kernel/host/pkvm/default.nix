# Copyright 2022-2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  lib,
  pkgs,
  fetchFromGitHub,
  ...
}:
let
  hyp_cfg = config.ghaf.host.kernel.hardening.hypervisor;
in
{
  config = lib.mkIf hyp_cfg.enable {
    boot.kernelPatches = [
      {
        name = "Hardened hypervisor kernel configuration";
        patch = null;
        extraStructuredConfig = with lib.kernel; {
          KVM_GUEST = yes;
          VIRTIO_INPUT = yes;
          VIRTIO_MMIO_CMDLINE_DEVICES = yes;
          DRM_VIRTIO_GPU = yes;
          VIRTIO_IOMMU = yes;
          VIRTIO_PMEM = yes;
          VIRTIO_VSOCKETS_COMMON = yes;
          VIRTIO_VSOCKETS = yes;
          ARM64_PTR_AUTH = yes;
          ARM64_PTR_AUTH_KERNEL = yes;
        };
      }
    ];
    boot.kernelParams = [
      "kvm-arm.mode=protected"
    ];
  };
}
