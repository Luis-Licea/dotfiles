{pkgs, ...}: {
  # nixpkgs.overlays = [
  #   (
  #     final: prev: {
  #       dwl = prev.dwl.overrideAttrs (
  #         old: {
  #           src = prev.fetchFromGitHub {
  #             owner = "luis-licea";
  #             repo = "dwl";
  #             rev = "f2532e266a4f2ad6d0b29c78058551f1cc3a6357";
  #             hash = "sha256-HxkGWAqHeqOvcueVrQ+Ebk17R5xMHO9aL/cHMdLi+pg=";
  #           };
  #         }
  #       );
  #     }
  #   )
  # ];

  environment = {
    systemPackages = with pkgs; [
      # (builtins.getFlake "github:Deleh/huepaper").defaultPackage.${pkgs.system}
      # (builtins.getFlake "github:Deleh/huepaper/048805bf049a6627c7611b4ec88617806e94d795").defaultPackage.${pkgs.system}
      greetd.tuigreet
      wireplumber
    ];

    etc."greetd/environments".text = ''
      dwl
    '';
  };

  services = {
    udisks2.enable = true;
    greetd = rec {
      enable = true;
      settings = {
        # Automatic login.
        initial_session = {
          command = /home/luis/.config/dwl/init.sh;
          user = "luis";
        };
        default_session = settings.initial_session;
        # default_session = with pkgs;
        # with lib; {
        #   command = ''
        #     ${getExe greetd.tuigreet} \
        #       --time \
        #       --asterisks \
        #       --user-menu \
        #       --cmd '${getExe dwl} \> $HOME/.cache/dwltags'
        #   '';
        # };
      };
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # Portal needed to make GTK apps happy.
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };

  # Necessary for DWL to work.
  hardware.opengl.enable = true;
  # hardware = {
  #   opengl.extraPackages = with pkgs; [
  #     rocm-opencl-icd
  #   ];
  # };
}
