let
  js-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM3PCmL6yPMIM3iV1CSoWmrAknwgFSEwQmGp6xBEs5NN";

  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7rkElzd36ff+EnWqAfXz/VedtqGqOfpshFf6wDsOSx";
in
{
  "nas-credentials.age".publicKeys = [
    laptop
    js-laptop
  ];
}
