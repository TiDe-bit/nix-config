{config, pkgs, ...}: 
{
  imports = [];

  environment.systemPackages = with pkgs; [
    oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    # enableCompletion = true;
    # autosuggestions.enable = true;
    # syntaxHighlighting.enable = true;
    # shellAliases = {
    #   ll = "ls -l";
    #   update = "sudo nixos-rebuild switch";
    #
    #   y = "yarn";
    #   yc = "yarn compile";
    #   yf = "yarn format";
    #   yl = "yarn lint";
    #   yfl = "y && yf && yl";
    #   yflc = "y && yf && yl && yc";
    #   yflcci = "y && yf && yl && yc && y test:ci";
    #   yflci = "y && yf && yl && y test:ci";
    #
    #
    #   maik = "make";
    #   tidy = "go mod tidy";
    #
    #
    #   kbooma = "kubectl get pods --field-selector='status.phase!=Succeeded,status.phase!=Running'";
    #   kubectx = "k ctx";
    #   kubewatch="watch -n 0.5 -c unbuffer 'kubecolor get pod | grep $1'";
    #   kw = "kubewatch";
    #
    #
    #   dogs = "docker logs -f";
    #   lw = "last_words";
    #   watchdogs = "watch -n 1 'docker ps -a --format \"table {{.ID}}\t\t{{.Status}}\t{{.Ports}}\t{{.Names}}\"'";
    #   fuckdocker = "docker volume prune && docker system prune  && docker rmi -f $(docker images -a -q) 2> /dev/null";
    #
    #   c = "clear";
    #   cc = "clear && zellij action clear";
    #   dots = "cd ~/dotfiles";
    #   n = "nvim .";
    #   glorm = "git pull origin master";
    #   vommit = "git commit -a";
    #   master = "git switch master && git fetch && git pull";
    #   main = "git switch main && git pull";
    #   lg="VISUAL=nvim lazygit";
    #   pfusch = "git commit -a --amend --no-edit --no-verify && gpf";
    #
    #   uuidgen = "uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n'";
    # };
    # ohMyZsh = {
    #   enable = true;
    #   plugins = [ "git" "rust" "kubectl" "aliases" ];
    #   theme = "robbyrussell"; # ignore - starship handles this
    # };
    #
    # interactiveShellInit = ''
    #   		export EDITOR="vim"
    #   		export VISUAL="vim"
    #
    #   		export GOPATH="$HOME/go"
    #   		export GOPRIVATE="gitlab.mittwald.it"
    #   		export GOPROXY="proxy.golang.org"
    #   		ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'
    #
    #   		export ZSH="$HOME/.oh-my-zsh"
    #   		export HYPRSHOT_DIR="~/Pictures/Screenshots"
    #
    #   		export NVM_DIR="$HOME/.nvm"
    #   		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    #   		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    #
    #   		# export PATH=$PATH:/$GOPATH/bin
    #   		export PATH="$PATH:$HOME/.krew/bin"
    #   		export PATH="$PATH:$HOME/.cargo/bin"
    #   		export PATH="$PATH:$GOPATH/bin"
    #
    #   		# Path to your oh-my-zsh installation.
    #   		export ZSH="$HOME/.oh-my-zsh"
    #
    #     	eval "$(zellij setup --generate-auto-start zsh)"
    #   		eval "$(starship init zsh --print-full-init)"
    #   	'';
    # promptInit = "";
    
    histSize = 20000;
    # history.ignoreAllDups = true;
    histFile = "$HOME/.zsh_history";
  };

  users.defaultUserShell = pkgs.zsh;
}
