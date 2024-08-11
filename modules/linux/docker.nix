{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
      dns = [ "1.1.1.1" "8.8.8.8" ];
    };
  };
}
