{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    marktext
  ];
}
