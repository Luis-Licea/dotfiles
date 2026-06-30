{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nvimpager
  ];

  environment.variables = {
    PAGER = "nvimpager";
  };
}
