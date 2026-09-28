{ pkgs, ... }:

# Optional: packages only this machine needs (hardware tools, proprietary
# apps). Shared packages belong in modules/.
{
  environment.systemPackages = with pkgs; [
    # marktext
    # nethack
  ];
}
