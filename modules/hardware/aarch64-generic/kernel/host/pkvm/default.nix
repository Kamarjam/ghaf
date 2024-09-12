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
  pkvmKernel = pkgs.nvidia-jetpack.kernelPackages.kernel.override {
    argsOverride = rec {
      version = "5.10.104";
      src = pkgs.fetchFromGitHub {
         owner = "Kamarjam";
         repo = "kernel-nvidia-jetson";
         rev = "d3b6397c1e8e6438b129f67cf13c02a01124716d"; 
         sha256 = "sha256-BMX8zfoe4OA+RSg5gKUn7trzgcG5rTym4/I80AYVJUA=";
      };
      kernelPatches = []; 
     };
   };

in
{
  config = lib.mkIf hyp_cfg.enable {
    
    # nixpkgs.overlays = lib.mkAfter [
    #   (_final: prev: {
    #     nvidia-jetpack = prev.nvidia-jetpack // {
    #       # kernelPackages = prev.nvidia-jetpack.kernelPackages // {
    #       #   kernel = pkvmKernel;  
    #       # };
    #       # jetpackVersion = "5.1.1";   
    #       # l4tVersion = "35.3.1";
    #       # cudaVersion = "11.4";
    #       kernel = prev.nvidia-jetpack.kernel.override ({
    #         argsOverride = rec {
    #           version = "5.10.104";
    #           extraMeta.branch = "5.10";
    #             src = pkgs.fetchFromGitHub {
    #               owner = "Kamarjam";
    #               repo = "kernel-nvidia-jetson";
    #               rev = "eebd1bc5950b930ccbd0e3558654a37267f0f01f"; 
    #               sha256 = "sha256-BMX8zfoe4OA+RSg5gKUn7trzgcG5rTym4/I80AYVJUA=";
    #             };
    #             kernelPatches = []; 
    #           };
    #         }
    #       );
    #     };
    #   })
    # ];
  
    boot.kernelPackages = lib.mkForce ( (pkgs.linuxPackagesFor pkvmKernel).extend (final: prev: {
      nvidia-display-driver = pkgs.nvidia-jetpack.kernelPackages.nvidia-display-driver;
    }));

  };
}
