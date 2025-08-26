let
  js-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM3PCmL6yPMIM3iV1CSoWmrAknwgFSEwQmGp6xBEs5NN";
  js-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLqvqY/GcYXdRtZQThNOtSBl7xjPhEx8ZuzzwO9f7Cg";

  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7rkElzd36ff+EnWqAfXz/VedtqGqOfpshFf6wDsOSx";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDfeu9napwgCdFGP121l4FLH1x9rnFmCsc+LzyQBFVps";
in
{
  "nas-credentials.age".publicKeys = [
    laptop
    js-laptop
  ];

  "js-hashed-password.age".publicKeys = [
    laptop
    js-laptop
  ];

  "laptop-root-hashed-password.age".publicKeys = [
    laptop
    js-laptop
  ];

  "nix-homelab-admin-ssh-key.age".publicKeys = [
    js-laptop
    js-desktop
  ];
}
