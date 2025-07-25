{ scriptsPath, backgroundPath, ... }: {
  ### MONITORS ###
  ################
  # See https://wiki.hyprland.org/Configuring/Monitors/
  monitor = [
    # "eDP-2, 1920x1080@120, 1600x0, 1"
    # "DP-4, 2560x1440@60, 2560x-1440, 1"
    # "DP-5, 2560x1440@60, 0x-1440, 1"
    ",preferred,auto,1"
  ];

  ###################
  ### MY PROGRAMS ###
  ###################
  "$terminal" = "ghostty";
  "$fileManager" = "dolphin";
  # The rofi menu variable was missing from your previous config, adding it back.
  "$menu" = "rofi --show drun";

  #################
  ### AUTOSTART ###
  #################
  exec-once = [
    "hypridle"
    "waybar"
    "wallust run ${backgroundPath}"
  ];

  #############################
  ### ENVIRONMENT VARIABLES ###
  #############################
  env = [
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SIZE,24"
    "ELECTRON_ENABLE_WAYLAND,1"
    "ELECTRON_OZONE_PLATFORM_HINT,wayland"
    "LIBVA_DRIVER_NAME,nvidia"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
  ];

  #####################
  ### LOOK AND FEEL ###
  #####################
  general = {
    gaps_in = 5;
    gaps_out = 5;
    border_size = 2;
    "col.active_border" = "rgba(00ff99ee) rgba(7851a9ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";
    resize_on_border = false;
    allow_tearing = false;
    layout = "dwindle";
  };

  decoration = {
    rounding = 10;
    active_opacity = 1.0;
    inactive_opacity = 1.0;
    shadow = {
      enabled = true;
      range = 4;
      render_power = 3;
      color = "rgba(1a1a1aee)";
    };
    blur = {
      enabled = true;
      size = 3;
      passes = 1;
      vibrancy = 0.1696;
    };
  };

  animations = {
    enabled = true;
    bezier = [
      "easeOutQuint,0.23,1,0.32,1"
      "easeInOutCubic,0.65,0.05,0.36,1"
      "linear,0,0,1,1"
      "almostLinear,0.5,0.5,0.75,1.0"
      "quick,0.15,0,0.1,1"
    ];
    animation = [
      "global, 1, 10, default"
      "border, 1, 5.39, easeOutQuint"
      "windows, 1, 4.79, easeOutQuint"
      "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
      "windowsOut, 1, 1.49, linear, popin 87%"
      "fadeIn, 1, 1.73, almostLinear"
      "fadeOut, 1, 1.46, almostLinear"
      "fade, 1, 3.03, quick"
      "layers, 1, 3.81, easeOutQuint"
      "layersIn, 1, 4, easeOutQuint, fade"
      "layersOut, 1, 1.5, linear, fade"
      "fadeLayersIn, 1, 1.79, almostLinear"
      "fadeLayersOut, 1, 1.39, almostLinear"
      "workspaces, 1, 1.94, almostLinear, fade"
      "workspacesIn, 1, 1.21, almostLinear, fade"
      "workspacesOut, 1, 1.94, almostLinear, fade"
    ];
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  master = {
    new_status = "master";
  };

  misc = {
    force_default_wallpaper = -1;
    disable_hyprland_logo = true;
  };

  #############
  ### INPUT ###
  #############
  input = {
    kb_layout = "us";
    kb_variant = "";
    kb_model = "";
    kb_options = "";
    kb_rules = "";
    follow_mouse = 1;
    sensitivity = 0;
    touchpad = {
      natural_scroll = true;
    };
  };

  gestures = {
    workspace_swipe = false;
  };

  device = {
    "name" = "epic-mouse-v1";
    "sensitivity" = -0.5;
  };

  ###################
  ### KEYBINDINGS ###
  ###################
  "$mainMod" = "SUPER";

  # App Variables
  "$firefox" = "firefox";
  "$code" = "code";
  "$discord" = "discord";
  "$spotify" = "spotify";
  "$obsidian" = "obsidian";
  "$WIFI_DEVICE" = "wlan0"; # Set your actual Wi-Fi device name here

  bind = [
    # Core Binds
    "$mainMod, Q, exec, $terminal"
    "$mainMod, C, killactive,"
    "$mainMod, M, exit,"
    "$mainMod, E, exec, $fileManager"
    "$mainMod, V, togglefloating,"
    "$mainMod, R, exec, $menu"
    "$mainMod, P, pseudo,"
    "$mainMod, J, togglesplit,"
    "$mainMod, F, fullscreen, 1"
    "$mainMod SHIFT, F, fullscreen, 0"
    "$mainMod, L, exec, hyprlock"
    "$mainMod, N, exec, swaync-client -t -sw"
    "$mainMod, Print, exec, grim -g \"$(slurp -d)\" - | tee $HOME/Pictures/Screenshots/screenshot-\"$(date +'%Y%m%d-%H%M%S')\".png | wl-copy"

    # Move focus
    "$mainMod, left, exec, ${scriptsPath}/toggle_fullscreen_movefocus.sh l"
    "$mainMod, right, exec, ${scriptsPath}/toggle_fullscreen_movefocus.sh r"
    "$mainMod, up, exec, ${scriptsPath}/toggle_fullscreen_movefocus.sh u"
    "$mainMod, down, exec, ${scriptsPath}/toggle_fullscreen_movefocus.sh d"

    # Scroll through existing workspaces
    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
    "$mainMod SHIFT, right, workspace, e+1"
    "$mainMod SHIFT, left, workspace, e-1"

    # App Bindings
    "$mainMod SHIFT, W, exec, $firefox"
    "$mainMod SHIFT, C, exec, $code"
    "$mainMod SHIFT, D, exec, $discord"
    "$mainMod SHIFT, S, exec, $spotify"
    "$mainMod SHIFT, O, exec, $obsidian"

    "$mainMod, W, exec, iwctl station $WIFI_DEVICE scan"
  ]
  # Generate keybinds for workspaces 1-9
  ++ (builtins.concatLists (builtins.genList (
    i: let ws = i + 1; in [
      "$mainMod, ${toString ws}, workspace, ${toString ws}"
      "$mainMod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
    ]
  ) 9))
  # Add workspace 10 on key 0
  ++ [
    "$mainMod, 0, workspace, 10"
    "$mainMod SHIFT, 0, movetoworkspace, 10"
  ];

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  # Laptop multimedia keys
  bindel = [
    ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
    ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
    ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
    ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
    ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
    ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
  ];

  # Playerctl keys
  bindl = [
    ",XF86AudioNext, exec, playerctl next"
    ",XF86AudioPause, exec, playerctl play-pause"
    ",XF86AudioPlay, exec, playerctl play-pause"
    ",XF86AudioPrev, exec, playerctl previous"
  ];

  ##############################
  ### WINDOWS AND WORKSPACES ###
  ##############################
  windowrulev2 = [
    "opacity 0.8 0.8,class:firefox"
    "opacity 0.8 0.8,class:com.mitchellh.ghostty"
    "opacity 0.7,class:code-oss"
    "opacity 0.7,class:spotify"
  ];

  windowrule = [
    "suppressevent maximize, class:.*"
    # Fix some dragging issues with XWayland
    "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
  ];

  layerrule = [
    "blur, waybar"
    "ignorezero, waybar"
    "ignorealpha 0.8, waybar"
  ];

  cursor = {
    no_hardware_cursors = true;
  };
}
