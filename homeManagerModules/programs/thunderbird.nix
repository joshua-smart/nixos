{ ... }: {
  programs.thunderbird = {
    enable = true;
    profiles.personal = { isDefault = true; };
  };
}