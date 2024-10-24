{config, pkgs, inputs, channels, ...}: 
{
  nixpkgs.overlays = [
    (import ../overlays/go.nix { inherit inputs; inherit config; })
    (import (builtins.fetchTarball {
      url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";
      sha256 = "sha256:1f41psqw00mdcwm28y1frjhssybg6r8i7rpa8jq0jiannksbj27s";
    } ))
  ];

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    zig
    bison
    flex
		unzip
    fontforge
    makeWrapper
    pkg-config
    gnumake
    gcc
    libiconv
    autoconf
    automake
    libtool
		nodePackages.npm
		python3

    vim
    neovim
    luarocks
    ripgrep
    fd
    fzf

		oh-my-zsh
    htop
    btop
    fastfetch
    stow
    gnupg
    pinentry-curses

    alacritty
    kitty
    killall
    starship
    zellij
    rustup
    go
    nodejs
    nodePackages.npm
    yarn
    protonmail-bridge-gui
    protonmail-bridge
    vscode
    jetbrains-toolbox
    bruno
    gnome-tweaks
    lazygit

    # misc
    webcord
    spotify
    evolution
    zoom-us
    slack
    spotify
    obs-studio
    imagemagick
    gimp
    krita
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    commit-mono
    martian-mono
    victor-mono
    nerdfonts
    font-awesome
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
