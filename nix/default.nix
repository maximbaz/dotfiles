{
  imports = [ ./nixos ./hardware ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.maximbaz = import ./home;
  };
}
