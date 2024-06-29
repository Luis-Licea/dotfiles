{pkgs, ...}: {
  # Use `gsettings list-recursively` to show all settings.
  dconf.settings = {

    # Workaround for freezing during activity switching on Ubuntu
    # "org/gnome/desktop/interface".enable-animations = false;
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      mic-mute = ["AudioMicMute"];
      next = ["AudioNext"];
      play = ["AudioPlay"];
      previous = ["AudioPrev"];
      stop = ["AudioStop"];
      volume-down = ["AudioLowerVolume"];
      volume-up = ["AudioRaiseVolume"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Shift><Alt>Return";
      command = "alacritty";
      name = "open-terminal";
    };

    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    #   # binding = "<Primary><Alt>t";
    #   binding = "<Alt><Shift>C";
    #   command = "alacritty";
    #   name = "open-terminal";
    # };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    # org.gnome.shell.extensions.forge.keybindings
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "forge@jmmaranan.com"
      ];
    };
    "org/gnome/shell/extensions/forge" = {
      tiling-mode-enabled = true;
      window-gap-size = 4;
      window-gap-size-increment = 1;
      window-gap-hidden-on-single = true;
    };

    "org/gnome/shell/extensions/forge/keybindings" = {
      # con-split-horizontal = [ "<Shift><Super>h" ];
      # con-split-vertical = [ "<Shift><Super>v" ];
      # con-split-layout-toggle = [ "<Shift><Super>g" ];
      # con-stacked-layout-toggle = [ "<Shift><Super>s" ];
      # con-tabbed-layout-toggle = [ "<Shift><Super>t" ];
      window-focus-down = ["<Alt>J"];
      window-focus-left = ["<Alt>H"];
      window-focus-right = ["<Alt>L"];
      window-focus-up = ["<Alt>K"];
      window-move-down = ["<Alt><Shift>J"];
      window-move-left = ["<Alt><Shift>H"];
      window-move-right = ["<Alt><Shift>L"];
      window-move-up = ["<Alt><Shift>K"];
      # window-resize-bottom-decrease = [ "<Shift><Alt><Super>Down" ];
      # window-resize-bottom-increase = [ "<Alt><Super>Down" ];
      # window-resize-left-decrease = [ "<Shift><Alt><Super>Left" ];
      # window-resize-left-increase = [ "<Alt><Super>Left" ];
      # window-resize-right-decrease = [ "<Shift><Alt><Super>Right" ];
      # window-resize-right-increase = [ "<Alt><Super>Right" ];
      # window-resize-top-decrease = [ "<Shift><Alt><Super>Up" ];
      # window-resize-top-increase = [ "<Alt><Super>Up" ];
      # window-toggle-always-float = [ "<Shift><Super>f" ];
      # window-toggle-float = [ "<Super>f" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Shift><Control><Super>l"];
    };
    "org/gnome/desktop/wm/keybindings" = {
      minimize = ["<Shift><Control><Super>h"];
      close = ["<Alt><Shift>C"];
      # };
      # "org/gnome/desktop/wm/keybindings" = {
      # close = ["<Alt>q"];
      move-to-workspace-1 = ["<Shift><Alt>1"];
      move-to-workspace-2 = ["<Shift><Alt>2"];
      move-to-workspace-3 = ["<Shift><Alt>3"];
      move-to-workspace-4 = ["<Shift><Alt>4"];
      move-to-workspace-5 = ["<Shift><Alt>5"];
      move-to-workspace-6 = ["<Shift><Alt>6"];
      move-to-workspace-7 = ["<Shift><Alt>7"];
      move-to-workspace-8 = ["<Shift><Alt>8"];
      move-to-workspace-9 = ["<Shift><Alt>9"];
      move-to-workspace-last = ["<Shift><Alt>0"];
      switch-to-workspace-1 = ["<Alt>1"];
      switch-to-workspace-2 = ["<Alt>2"];
      switch-to-workspace-3 = ["<Alt>3"];
      switch-to-workspace-4 = ["<Alt>4"];
      switch-to-workspace-5 = ["<Alt>5"];
      switch-to-workspace-6 = ["<Alt>6"];
      switch-to-workspace-7 = ["<Alt>7"];
      switch-to-workspace-8 = ["<Alt>8"];
      switch-to-workspace-9 = ["<Alt>9"];
      switch-to-workspace-last = ["<Alt>0"];
      toggle-fullscreen = ["<Alt>f"];
      toggle-maximized = ["<Alt>m"];

      switch-applications = [];
      switch-applications-backward = [];

      switch-windows = [];
      switch-windows-backward = [];

      cycle-windows = ["<Alt>Tab"];
      cycle-windows-backward = ["<Alt><Shift>Tab"];
    };


    # Alt-Tab only shows tasks in current desktop.
    "org/gnome/shell/window-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 9;
    };

    "org/gnome/desktop/input-sources" = {
      # Overwrite AltGr kay so it works as a regular Alt.
      xkb-options = ["terminate:ctrl_alt_bksp" "lv3:rwin_switch"];
    };
  };
}
