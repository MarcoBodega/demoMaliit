#!/bin/sh

PID=$(pidof -s maliit-server)
ENVIRON="$(tr '\0' '\n' < /proc/${PID}/environ | grep "DBUS_SESSION_BUS_ADDRESS" | cut -d "=" -f 2-)"
export DBUS_SESSION_BUS_ADDRESS="${ENVIRON}"

export MALIIT_KEYBOARD_DATA_DIR=/usr/local/share/maliit/plugins/org/maliit/
#export QT_PLUGIN_PATH=/home/user/plugins
export QT_IM_MODULE=Maliit
export MALIIT_DEBUG=1
#export QT_DEBUG_PLUGINS=1

/home/bodegam/projects/build-demoMaliit-Qt_5_5_1-Debug/demoMaliit &

