# Copyright 2022-2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{ config, lib, ... }:
let
  cfg = config.ghaf.hardware.aarch64.common;
in
{
# Empty at the moment. move generic items from reference/hardware/jetpack/ here.

  options.ghaf.hardware.aarch64.common = {
    enable = lib.mkEnableOption "Common aarch64 configs";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.hostPlatform.system = "aarch64-linux";
  };
}
