# Copyright 2022-2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{ ... }:
{
  imports = [
    ./host/pkvm
    # other host hardening modules - to be defined later
  ];

  config = {
    # host kernel hardening
    ghaf = {
      host = {
        kernel.hardening = {
          enable = true;
          virtualization.enable = true;
          networking.enable = true;
          usb.enable = true;
          inputdevices.enable = true;
          debug.enable = true;
          # host kernel hypervisor (KVM) hardening
          hypervisor.enable = true;
        };
      };
    };
  };
}
