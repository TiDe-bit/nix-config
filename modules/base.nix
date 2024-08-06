{config, pkgs, ...}: 
{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };


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

		oh-my-zsh
    htop
    stow
    gnupg
    pinentry-curses
    
    alacritty
    kitty
    starship
    zellij
    cargo
    go
    vscode
    jetbrains-toolbox
    bruno
    gnome.gnome-tweaks
    lazygit

    # misc
    webcord
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
