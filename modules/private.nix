{config, pkgs, ...}: 
{
  imports = [];

  environment.systemPackages = with pkgs; [
    ausweisapp
  ];
}
