{
  imports = [ ./nixosConfigurations ./hardwareProfiles ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.maximbaz = import ./homeProfiles;
  };
}
