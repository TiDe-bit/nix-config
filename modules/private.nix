{config, pkgs, ...}: 
{
  imports = [];

  environment.systemPackages = with pkgs; [
    libreoffice-qt
    gnome.gnome-boxes
    ausweisapp
  ];
}
