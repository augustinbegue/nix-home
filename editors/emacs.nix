{ lib, pkgs, ... }:

let vars = import ../common/vars.nix;
in
{
  programs.emacs = {
    enable = true;
  };
}