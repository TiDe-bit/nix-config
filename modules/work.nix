{config, pkgs, ...}: 
{
  imports = [];

  environment.systemPackages = with pkgs; [
    slack
    zoom
    kubectl
    kubectx
    kubecolor
    helm
    kubernetes-helm
    firefox-devedition
    # install jordi via cargo
  ];
}
