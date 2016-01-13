#!/bin/sh

# https://community.kde.org/Plasma/Mobile/VirtualKeyboard

#force the active im to be used
#gconftool-2 --set "/maliit/onscreen/enabled" --type list --list-type=string [nemo-keyboard.qml,en_us]
#gconftool-2 --set "/maliit/onscreen/active" --type list --list-type=string [nemo-keyboard.qml,en_us]
#gconftool-2 --set "/maliit/onscreen/enabled" --type list --list-type string "[libmaliit-keyboard-plugin.so,en_gb]"
#gconftool-2 --set "/maliit/onscreen/active" --type list --list-type string "[libmaliit-keyboard-plugin.so,en_gb]"

#but remember this: /etc/xdg/maliit.org/server.conf
#[maliit]
#; onscreen\active=libmaliit-keyboard-plugin.so:en_us
#; onscreen\active=nemo-keyboard.qml:en_us
#; onscreen\active=libubuntu-keyboard-plugin.so:en_us

#make sure org.kde.plasma.core can be imported
#export QML_IMPORT_PATH=/usr/lib/kde4/imports/

#enable maliit plugin
export QT_IM_MODULE=maliit 
export MALIIT_DEBUG=enabled #1
export QT_LOGGING_TO_CONSOLE=1 #Qt >= 5.4
#export QT_DEBUG_PLUGINS=1
#export QML_IMPORT_TRACE=1
export MALIIT_KEYBOARD_DATA_DIR=/usr/local/share/maliit/plugins/org/maliit

killall maliit-server
eval `dbus-launch --auto-syntax`
maliit-server & 

wait
