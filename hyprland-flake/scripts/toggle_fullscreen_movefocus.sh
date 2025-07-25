#!/bin/bash

direction="$1"
lock_file="/tmp/.hypr_movefocus_lock" # Using a dot file for 'hidden' temp file

# --- Lock File Mechanism ---
# Check if lock file exists and if the process holding the lock is still running
if [ -f "$lock_file" ]; then
    locked_pid=$(cat "$lock_file" 2>/dev/null)
    # Check if locked_pid is a number and if the process exists
    if [[ "$locked_pid" =~ ^[0-9]+$ ]] && ps -p "$locked_pid" > /dev/null 2>&1; then
        # Optional: Notify that it's already running
        # notify-send "Hyprland Focus Move" "Already in progress..." -t 1000
        exit 0 # Exit silently if already running
    else
        # Stale lock file (PID not running or file empty/corrupt)
        # Optional: notify-send "Hyprland Focus Move" "Removing stale lock..." -t 1000
        rm -f "$lock_file"
    fi
fi

# Create the lock file with the current script's PID
echo $$ > "$lock_file"

# Ensure the lock file is removed when the script exits (normally, or via signal)
trap 'rm -f "$lock_file"' EXIT HUP INT QUIT PIPE TERM
# --- End Lock File Mechanism ---

# Get active window's fullscreen state *once*
active_window_info=$(hyprctl activewindow)
is_fullscreen=$(echo "$active_window_info" | grep 'fullscreen:' | awk -F ': ' '{print $2}' | tr -d ',')
needs_fullscreen_restore=false

# If the current window is fullscreen, temporarily exit fullscreen
if [ "$is_fullscreen" = "1" ]; then
  hyprctl dispatch fullscreen 1 # This toggles fullscreen. If it was 1 (on), it becomes 0 (off).
  needs_fullscreen_restore=true
  # Add a tiny delay if necessary for the fullscreen state to update before moving focus
  # sleep 0.05
fi

# Move focus to the desired direction
hyprctl dispatch movefocus "$direction"

# Add a small delay for the focus change to complete and the new window to become active.
# This helps ensure the subsequent fullscreen command targets the correct window.
# Adjust this value based on your system's responsiveness.
sleep 0.1 # Reduced from 0.5, as the lock prevents re-entrancy issues.

# If the original window was fullscreen, restore fullscreen on the new active window
if [ "$needs_fullscreen_restore" = true ]; then
  # It's possible the new window already is fullscreen from some other rule.
  # However, if we just toggled the old one off, we likely want the new one on.
  hyprctl dispatch fullscreen 1 # This toggles fullscreen. If it was 0 (off), it becomes 1 (on).
fi

# The lock file will be removed by the trap on EXIT
exit 0
