{ pkgs, ... }:
{
  imports = [ <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> ];
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYYsVZc4wkyT3ZE/f0/1aIXPFjl+XSxUsLGIE2p+B1kQ0hvrz6+d7u7Vvk6GIqI1+n6CEgNOgLKJQgiTy3A+Davotpg6cr4fTMAkOO1rXQWqCKAixy/TgXziBxTV6Jd5GcBnVl8hVQur8jAht1d041zpF51mIUpc2H6eQOi0aM8Xgw3QD5v7zKvZRQuwivk4hU5aNVIQW8Cd5TN7QJWR5/U51I613c5kw2QRRfGedl9TY0S7bhs38GTp0mzGdOllph3kW3BryIabeyvEbLaSwL3J6gY1d/vEuSGaiUTsdjgELQV4OdId/oqA4UrGK4ky/G/WiovSQjhB7mTgXc9RELyscrlRiByhSa0nLWW1S1bE936e1CMPWxHVcN0bMana1ckCGgBILYldus1G2EakQLhOi+gcSz/uBEDybyZ+U2odloep2Q2TpKC1IX5Uq6y8MAUmxuIUfn2U3kHrZvqQoYaQEHu35kHldOU48GBl84zSE9Jho/mXjZZOJYmqk89kXkjm5IjEHsF/l0GKz/HtWLkdSXek0Yy1JRN+HI00iyYb/ILCGGlcCznzY56emCAwN8PRCa5AvyC5lCfCm/SiE7VNqRK21eH/X1cbAS1g/Yx+NTstFH+3lEj4H/UP7We0N3+lc0vteh88sriuHgLYylnJA0DFL0ptteLCo9TeeAmQ== cardno:000608752585" ];
  networking.firewall.enable = false;
  environment.systemPackages = with pkgs; [ conspy wget vim stress ];
  systemd.services.ghostnet = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.steam-run-native ];
    script = "EVEREST_HEADLESS=1 steam-run ./Celeste --headless --server";
    serviceConfig = {
      User = "root";
      WorkingDirectory = "/root/Celeste";
      CPUQuota = "25%";
    };
  };
  systemd.services.minecraft = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.jre8 ];
    script = "java -XX:+UseG1GC -Xmx3G -Xms3G -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -jar ./FTBserver.jar nogui";
    restartIfChanged = false; # 20 minutes later...
    serviceConfig = {
      StandardInput = "tty-force";
      TTYVHangup = "yes";
      TTYPath = "/dev/tty20";
      TTYReset = "yes";
      Restart = "always";
      User = "root";
      WorkingDirectory = "/root/minecraft";
    };
  };
}
