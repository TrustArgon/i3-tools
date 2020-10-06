#!/bin/bash
# Monitor Switching Script for i3 Laptop
# Map this script in i3 config. Example:
#	bindsym $mod+p exec --no-startup-id ~/.config/i3/display.sh
# Make sure to make the script executable:
#	chmod +x ~/.config/i3/display.sh
# 
# This script presents four display configuration options
#	1. External
#	2. Internal
#	3. Dual
#	4. Clone


# Configure Primary Display (run `xrandr` to get this)
INTERNAL_OUTPUT="eDP-1"

# Display configuration options displayed
displays="External\nInternal\nDual\nClone"

# Mapping choice to variable for xrandr command selection
c_display=$(echo -e $displays | dmenu -i)

# Identifying external displays.
# NOTE: The grep terms may require some tweaking based on your OS,
#	make sure to do your homework or this script may cause you 
#	more headaches than you bargained for.

if [ `xrandr | grep '^DP-1 ' | grep -c ' connected '` -eq 1 ]; then
	EXTERNAL_DISPLAY="DP-1"
fi
if [ `xrandr | grep HDMI-1 | grep -c ' connected '` -eq 1 ]; then
	EXTERNAL_DISPLAY="HDMI-1"
fi
if [ `xrandr | grep DP-2 | grep -c ' connected '` -eq 1 ]; then
	EXTERNAL_DISPLAY="DP-2"
fi
if [ `xrandr | grep HDMI-2 | grep -c ' connected '` -eq 1 ]; then
	EXTERNAL_DISPLAY="HDMI-2"
fi
if [ `xrandr | grep DP-3 | grep -c ' connected '` -eq 1 ]; then
	EXTERNAL_DISPLAY="DP-3"
fi
if [ `xrandr | grep DP-1-1 | grep -c ' connected '` -eq 1 ]; then
	EXTERNAL_DISPLAY="DP-1-1"
fi
if [ `xrandr | grep DP-1-2 | grep -c ' connected '` -eq 1 ]; then
	EXTERNAL_DISPLAY="DP-1-2"
fi
if [ `xrandr | grep DP-1-3 | grep -c ' connected '` -eq 1 ]; then
	EXTERNAL_DISPLAY="DP-1-3"
fi

# xrandr commands to run based on chosen display configuration
# if a 3 display option exists or is desired, this will require changes
case "$c_display" in
	External) xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_DISPLAY --auto --primary ;;
	Internal) xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_DISPLAY --off ;;
	Dual) xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_DISPLAY --auto --right-of $INTERNAL_OUTPUT --primary ;;
	Clone) xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_DISPLAY --auto --same-as $INTERNAL_OUTPUT ;;
esac
