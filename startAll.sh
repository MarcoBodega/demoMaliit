#!/bin/bash

# Run this script using the command "./keyboard_demo.sh"
export MALIIT_DEBUG=enabled

# Kill existing services
killall maliit-server
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
export MALIIT_KEYBOARD_DATA_DIR=/usr/local/share/maliit/plugins/org/maliit/
export QT_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins # Provide plugin location
export QT_IM_MODULE=Maliit # Turn on the keyboard dbus plugin

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

# Turn on the maliit server
#env DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS QT_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins QT_IM_MODULE=Maliit maliit-server &
maliit-server &

# Turn on the example app
#env DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS QT_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins QT_IM_MODULE=Maliit /home/bodegam/projects/build-demoMaliit-Qt_5_5_1-Debug/demoMaliit &
~/projects/build-demoMaliit-Qt_5_5_1-Debug/demoMaliit &

wait

