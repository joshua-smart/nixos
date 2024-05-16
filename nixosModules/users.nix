{ ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.js = {
    isNormalUser = true;
    description = "Joshua Smart";
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "js";
}
