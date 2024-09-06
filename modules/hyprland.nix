{ pkgs, ...}: 
{
  imports = [];

  services.xserver.displayManager.gdm.wayland = true;
  programs.hyprland = {    
    enable = true;    
    xwayland.enable = true;    
  };
  environment.sessionVariables =  {
    # XCURSOR_THEME="Adwaita";
    # XDG_CACHE_HOME  = "$HOME/.cache";
    # XDG_CONFIG_HOME = "$HOME/.config";
    # XDG_DATA_HOME   = "$HOME/.local/share";
    # XDG_STATE_HOME  = "$HOME/.local/state";
    #
    # # Not officially in the specification
    # XDG_BIN_HOME    = "$HOME/.local/bin";
    # PATH = [ 
    #   "${XDG_BIN_HOME}"
    # ];
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
    # WARNING: this package seems to be broken currently
    # blueman
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
