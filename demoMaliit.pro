##########################
# USAGE:

# change this definition
#CONFIG += maliit
CONFIG += mockup

# define this env var
#QT_IM_MODULE=mockup OR maliit
############################

TEMPLATE = app

QT += qml quick
QT += gui-private core-private

maliit {
    # requirements:
    # Qt 5.5.1
    # Maliit 0.99.1

    # ENVIRONMENT
    #MALIIT_DEBUG=1
    #MALIIT_KEYBOARD_DATA_DIR=/usr/local/share/maliit/plugins/org/maliit/
    #QT_DEBUG_PLUGINS=1
    #QT_IM_MODULE= maliit

    # run from: ./startAll.sh

    QT += dbus
    CONFIG += link_pkgconfig
    CONFIG += c++11
    CONFIG += qt5-inputcontext

    PKGCONFIG += maliit-framework maliit-plugins
    # maliit-glib

    #INCLUDEPATH += /usr/local/include/maliit/ /usr/local/include/maliit/framework /usr/local/include/maliit/plugins
    INCLUDEPATH += /home/bodegam/projects/upstream/maliit /home/bodegam/projects/upstream/maliit/framework/src /home/bodegam/projects/upstream/maliit/framework/common /home/bodegam/projects/upstream/maliit/framework/connection /home/bodegam/projects/upstream/maliit/framework/input-context /home/bodegam/projects/upstream/maliit/framework/maliit-glib /home/bodegam/projects/upstream/maliit/plugins
    LIBS += -L/usr/local/lib/ -L/usr/local/lib/qt5/plugins/platforminputcontext/

    # Additional import path used to resolve QML modules in Qt Creator's code model
    QML_IMPORT_PATH = /usr/local/share/maliit/plugins/org/maliit/

    DEFINES += MALIIT
}

mockup {
    # http://tolszak-dev.blogspot.it/2013/04/qplatforminputcontext-and-virtual.html
    # http://quickgit.kde.org/?p=scratch%2Ftolszak%2FMockupVirtualKeyboard.git

    # create folder "platforminputcontexts" under this project build dir and
    # inside it make a link to libMockupVirtualKeyboard.so built from "MockupVirtualKeyboard.git"

    # ENVIRONMENT
    #QT_IM_MODULE=mockup

    # run directly from QtCreator

    INCLUDEPATH += /home/bodegam/projects/MockupVirtualKeyboard/
    #LIBS += -L/home/bodegam/projects/build-MockupVirtualKeyboard-Qt_5_5_1-Debug -lMockupVirtualKeyboard

    DEFINES += MOCKUP
}


SOURCES += main.cpp
RESOURCES += qml.qrc


# Default rules for deployment.
include(deployment.pri)

