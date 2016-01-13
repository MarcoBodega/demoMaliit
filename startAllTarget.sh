#!/bin/bash

# Run this script using the command "./keyboard_demo.sh"


# Kill existing services
killall maliit-server
killall BtClass
killall demoMaliit

# Search processes for the dbus-daemon session bus PID
PID=$(ps | grep "dbus-daemon" | grep "session" | grep "bodegam" | cut -d' ' -f3)

# If there is no PID for a session bus then start a session bus
# and grab the resulting pid
if [[ "${PID}" == "" ]]; then
    echo "No existing dbus session bus... Starting one now."
    eval $(dbus-launch --sh-syntax)
    sleep 3
    export DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS
    export DBUS_SESSION_BUS_PID=$DBUS_SESSION_BUS_PID
    #PID=$(ps | grep "dbus-daemon" | grep "session" | cut -d' ' -f3)
    PID=$DBUS_SESSION_BUS_PID
    echo $PID
else 
    echo "Existing DBUS session bus found..."
fi

# Export the keyboard variables
export MALIIT_KEYBOARD_DATA_DIR=${STAGING_SYSROOT}/usr/share/maliit/plugins/org/maliit/
export QT_PLUGIN_PATH=${OE_QMAKE_LIBDIR_QT}/qt5/plugins # Provide plugin location
export QT_IM_MODULE=Maliit # Turn on the keyboard dbus plugin
export MALIIT_DEBUG=enabled

# Echo the env variables
echo ""
echo "#### Echo the env variables ####"
echo ""
echo "QT_PLUGIN_PATH: " $QT_PLUGIN_PATH
echo "QT_IM_MODULE: " $QT_IM_MODULE
echo "DBUS_SESSION_BUS_ADDRESS: " $DBUS_SESSION_BUS_ADDRESS
echo "DBUS_SESSION_BUS_PID: " $DBUS_SESSION_BUS_PID
echo ""
echo "################################"
echo ""

# Something nasty happened
if [[ "${DBUS_SESSION_BUS_ADDRESS}" == "" ]]; then
    echo "We don't have a DBUS session address!"
    return 1
fi

export QT_QPA_EGLFS_HIDECURSOR=1
#export QT_QPA_EGLFS_TSLIB=1
export QT_QPA_PLATFORM=eglfs
export QT_EGLFS_IMX6_NO_FB_MULTI_BUFFER=1
export QT_QPA_EGLFS_PHYSICAL_WIDTH=152 #216
export QT_QPA_EGLFS_PHYSICAL_HEIGHT=86 #135
export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS="rotate=180 :invertx"

# Turn on the maliit server
#env DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS QT_PLUGIN_PATH=${OE_QMAKE_LIBDIR_QT}/qt5/plugins QT_IM_MODULE=Maliit maliit-server &
maliit-server &

# Turn on the example app
#env DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS QT_PLUGIN_PATH=${OE_QMAKE_LIBDIR_QT}/qt5/plugins QT_IM_MODULE=Maliit ./demoMaliit &
./demoMaliit &

echo 65 > /sys/class/backlight/i2c_kb_touch-bl/brightness
#ts_calibrate
cat /dev/zero > /dev/fb0

wait

