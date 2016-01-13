import QtQuick 2.4
import QtQuick.Window 2.2





//Window {
Item {
        visible: true
        width: 200
        height: 200

        MainForm {
                anchors.fill: parent
                /*mouseArea.onClicked: {
                        Qt.quit();
                }*/
        }

        /*Component.onCompleted: {
            if (hasEmbeddedKeyboard)
                console.log("MInputMethodQuick: ", MInputMethodQuick)
                //MInputMethodQuick.currentLayout = global.keyboardLayout
        }

        Loader {
            id: keyboardLoader
            visible: false
            anchors.fill: parent
            z: 101
            source: hasEmbeddedKeyboard ? MInputMethodQuick.qmlFileName : ""

            Connections {
                target: hasEmbeddedKeyboard ? MInputMethodQuick : null

                onActiveChanged: {
                    if (MInputMethodQuick.active) {
                        // In some cases we have a quick active/not-active/active
                        // transition (eg. when changing input fields in a web
                        // page) so we need to stop the hiding timer when going
                        // in active state again
                        hideKeyboardTimer.stop()
                        keyboardLoader.visible = true
                    }
                    else
                        hideKeyboardTimer.start()
                }
            }

            Timer {
                id: hideKeyboardTimer
                interval: 500 // the time needed by the keyboard to perform the hide animation
                onTriggered: keyboardLoader.visible = false
            }
        }*/

}



/*
Rectangle {
    id: canvas
    width: MInputMethodQuick.screenWidth
    height: MInputMethodQuick.screenHeight
    color: "transparent"

    Rectangle {
        id: imArea
        width: MInputMethodQuick.screenWidth
        height: MInputMethodQuick.screenHeight * 0.5
        radius: 10
        color: "grey"
        border.color: "black"
        border.width: 10
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: buttonText
            text: "Hello World!"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: MInputMethodQuick.sendCommit(buttonText.text)
        }
    }

    Component.onCompleted: {
        MInputMethodQuick.setInputMethodArea(Qt.rect(0, MInputMethodQuick.screenHeight - imArea.height,
                                                     imArea.width, imArea.height))
        MInputMethodQuick.sendCommit("Maliit")
        MInputMethodQuick.sendPreedit("Maliit")
    }
}*/
