{
  general = {
    lock_cmd = "pidof hyprlock || hyprlock";
    before_sleep_cmd = "loginctl lock-session";
    after_sleep_cmd = "hyprctl dispatch dpms on";
  };

  listeners = [
    {
      timeout = 600;      
      on-timeout = "brightnessctl -s set 10 && brightnessctl -sd rgb:kbd_backlight set 0 && hyprctl dispatch dpms off";
      on-resume = "brightnessctl -r && brightnessctl -rd rgb:kbd_backlight && hyprctl dispatch dpms on";
    }

    {
      timeout = 600;
      on-timeout = "pidof hyprlock || hyprlock";
    }

    {
      timeout = 3600;
      on-timeout = "systemctl suspend";
    }
  ];
}
