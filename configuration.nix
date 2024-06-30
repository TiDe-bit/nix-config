# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./hyprland.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-2406fb5b-4c10-422c-abbb-e1abb5d0e0b2".device = "/dev/disk/by-uuid/2406fb5b-4c10-422c-abbb-e1abb5d0e0b2";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    variant = "nodeadkeys";
    layout = "de";
  };
  
  services.xserver.displayManager.gdm.wayland = true;
  programs.hyprland = {    
    enable = true;    
    xwayland.enable = true;    
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tdellmann = {
    isNormalUser = true;
    description = "tdellmann";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      thunderbird
    ];
  };


  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    pinentry
    
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

    # hyprland
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
  ];

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    # syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";

      y = "yarn";
      yc = "yarn compile";
      yf = "yarn format";
      yl = "yarn lint";
      yfl = "y && yf && yl";
      yflc = "y && yf && yl && yc";
      yflcci = "y && yf && yl && yc && y test:ci";
      yflci = "y && yf && yl && y test:ci";


      maik = "make";
      tidy = "go mod tidy";


      kbooma = "kubectl get pods --field-selector='status.phase!=Succeeded,status.phase!=Running'";
      kubectx = "k ctx";
      kubewatch = "watch -n 0.5 'kubectl get pod | grep $1'";
      kw = "kubewatch";


      dogs = "docker logs -f";
      lw = "last_words";
      watchdogs = "watch -n 1 'docker ps -a --format \"table {{.ID}}\t\t{{.Status}}\t{{.Ports}}\t{{.Names}}\"'";
      fuckdocker = "docker volume prune && docker system prune  && docker rmi -f $(docker images -a -q) 2> /dev/null";

      c = "clear";
      cc = "clear && zellij action clear";
      n = "nvim .";
      glorm = "git pull origin master";
      vommit = "git commit -a";
      master = "git switch master && git fetch && git pull";
      main = "git switch main && git pull";
      pfusch = "git commit -a --amend --no-edit --no-verify && gpf";

      uuidgen = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n'";
    };
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "rust" "kubectl" "aliases" ];
      theme = "robbyrussell"; # ignore - starship handles this
    };

    interactiveShellInit = ''
      		export EDITOR="vim"
      		export VISUAL="vim"

      		export GOPATH="$HOME/go"
      		export GOPRIVATE="gitlab.mittwald.it"
      		export GOPROXY="proxy.golang.org"
      		ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

      		export ZSH="$HOME/.oh-my-zsh"
      		export HYPRSHOT_DIR="~/Pictures/Screenshots"


      		export NVM_DIR="$HOME/.nvm"
      		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

      		# export PATH=$PATH:/$GOPATH/bin
      		export PATH="$PATH:$HOME/.krew/bin"
      		export PATH="$PATH:$HOME/.cargo/bin"
      		export PATH="$PATH:$GOPATH/bin"

      		# Path to your oh-my-zsh installation.
      		export ZSH="$HOME/.oh-my-zsh"

        	eval "$(zellij setup --generate-auto-start zsh)"
      		eval "$(starship init zsh --print-full-init)"

      		# ZELLIH setup
      		if [[ -z "$ZELLIJ" ]]; then
          	if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
            	zellij attach -c
          	else
              zellij
          	fi
          	if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
              exit
          	fi
      		fi
      	'';
    promptInit = "";

    histSize = 10000;
    histFile = "$HOME/.zsh-history";
  };

  users.defaultUserShell = pkgs.zsh;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
