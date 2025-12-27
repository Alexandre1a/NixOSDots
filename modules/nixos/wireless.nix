{ config, ... }:

{
  sops.secrets."secrets/freebox-password" = {
    owner = "root";
    group = "root";
    mode = "0400";
  };

  networking.wireless.networks = {
    Freebox-357429 = {
      pskRaw = "ext:${config.sops.secres."secrets/freebox-password".path}";
    };
  };
}
