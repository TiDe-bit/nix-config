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
    wl-clipboard
    kanshi
    swww

    networkmanagerapplet
    rofi-wayland
    pavucontrol
    waybar

    sway
    swaylock-effects
    swayidle
    swaynotificationcenter
    grim
    slurp

    hypridle
    hyprpaper
    hyprlock
    hyprshot
    # mako
    # WARNING: this package seems to be broken currently
    # blueman
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
