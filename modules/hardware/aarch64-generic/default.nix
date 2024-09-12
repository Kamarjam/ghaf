# Copyright 2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  imports = [
    ./kernel/hardening.nix
    ./kernel/host/pkvm
    ./aarch64-linux.nix
  ];
}