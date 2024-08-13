{config, pkgs, ...}: 
{
  imports = [];

  services.xserver.displayManager.gdm.wayland = true;
  programs.hyprland = {    
    enable = true;    
    xwayland.enable = true;    
  };

  environment.systemPackages = with pkgs; [
    hypridle
    hyprpaper
    hyprlock
    hyprshot
    mako
    rofi-wayland
    waybar
    pavucontrol
    blueman
    networkmanagerapplet
    wl-clipboard
    kanshi
    swww
  ];

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };
}
