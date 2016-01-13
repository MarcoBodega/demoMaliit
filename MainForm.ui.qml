import QtQuick 2.4

Rectangle {
    //property alias mouseArea: mouseArea

    width: 200
    height: 200

    /*MouseArea {
        id: mouseArea
        anchors.fill: parent
    }*/

    Text {
        id: textId
        anchors.centerIn: parent
        text: "Hello World"
    }

    TextInput {
        id: textInput1
        width: 80
        height: 20
        anchors.top: textId.bottom
        anchors.horizontalCenter:  textId.horizontalCenter
        focus: true
        text: qsTr("Text Input")
        font.pixelSize: 12
    }

    /*FocusScope {
       id: focusScope
       width: 80
       height: 20
       anchors.top: textId.bottom
       anchors.horizontalCenter:  textId.horizontalCenter

       focus: true

       TextInput {
           id: textInput1
           anchors.fill: parent
           focus: true
           text: qsTr("Text Input")
           font.pixelSize: 12
       }
    }*/



    /*TextInput {
        id: textInput1
        width: 80
        height: 20
        anchors.top: textId.bottom
        anchors.horizontalCenter:  textId.horizontalCenter
        text: qsTr("Text Input")
        font.pixelSize: 12
    }*/
}

