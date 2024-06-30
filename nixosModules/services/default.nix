{ ... }:
{
  imports = [ ];

  services = {
    openssh.enable = true;
    printing.enable = true;
    udisks2.enable = true;
  };
}
