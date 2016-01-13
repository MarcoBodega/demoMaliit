#!/bin/bash

killall maliit-server
killall BtClass
killall demoMaliit

export QT_IM_MODULE=mockup

./demoMaliit -platform eglfs