{ pkgs, ... }:
{
  imports = [ ];

  # environment.variables.GTK_THEME = "Adawaita:dark";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  services.pipewire.wireplumber.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
      # xdg-desktop-portal-gtk
    ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  environment.sessionVariables = {
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

    swaylock-effects
    swayidle
    wdisplays
    swaynotificationcenter
    swaysome
    swayest-workstyle
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
