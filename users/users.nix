{ config, lib, pkgs, ... }:

# let
#   home-manager = builtins.fetchGit {
#     url = "https://github.com/rycee/home-manager.git";
#     rev = "612afee126c664121cb8bc071b999696513df808";
#     ref = "release-20.09";
#   };
# in
# 
# {
#   imports = [ 
#     (import "${home-manager}/nixos")
#   ];
let
  home-manager = import ( builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz" )  { };
in

{
  # TODO: use a variable for the username
  imports = [ home-manager.nixos ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixos = {
    isNormalUser = true;
    home = "/home/nixos";
    extraGroups = [ "audio" "sound" "wheel" ];
    shell = pkgs.fish;
  };

  fileSystems."/home/nixos/faststorage" = {
    device = "/faststorage";
    fsType = "9p";
    options = [ "trans=virtio" "version=9p2000.L" ];
  };

  home-manager.users.nixos = import /home/nixos/.config/nixpkgs/home.nix;
}
