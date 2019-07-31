import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: config
    width: 400
    height: 400
    color: "#e7e6e6"
    property alias configTitle: configTitle
    property alias passwordField: passwordField
    property alias loginField: loginField
    property alias urlField: urlField
    property alias config: config
    property alias configCancelButton: configCancelButton
    property alias configOkButton: configOkButton

    Label {
        id: configLabel
        y: 8
        width: 132
        height: 27
        color: "#000000"
        text: qsTr("Config Dialog")
        anchors.left: parent.left
        anchors.leftMargin: 8
        font.bold: true
        font.pointSize: 13
        font.family: "Arial"
    }

    Label {
        id: configTitle
        x: 184
        y: 62
        width: 88
        height: 18
        text: qsTr("NextCloud")
        font.pointSize: 11
        font.weight: Font.ExtraLight
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Grid {
        id: grid
        y: 106
        height: 294
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

    Label {
        id: urlLabel
        x: 60
        y: 120
        width: 28
        height: 26
        text: qsTr("Url:")
        font.pointSize: 11
    }

    TextField {
        id: urlField
        x: 156
        y: 120
        text: qsTr("")
        placeholderText: "Url to Nextcloud Server"
    }

    Label {
        id: loginLabel
        x: 60
        y: 191
        width: 45
        height: 25
        text: qsTr("Login:")
        font.pointSize: 11
    }

    TextField {
        id: loginField
        x: 156
        y: 184
        text: qsTr("")
        placeholderText: "Login  Name"
    }

    Label {
        id: label1
        x: 58
        y: 253
        width: 72
        height: 22
        text: qsTr("Password:")
        font.pointSize: 11
    }

    TextField {
        id: passwordField
        x: 156
        y: 244
        text: qsTr("")
        placeholderText: "Password"
        echoMode: TextInput.Password
    }

    ToolButton {
        id: configOkButton
        x: 60
        y: 325
        width: 80
        height: 40
        text: qsTr("OK")
    }

    ToolButton {
        id: configCancelButton
        x: 274
        y: 325
        width: 82
        height: 40
        text: qsTr("Cancel")
    }
}




/*##^## Designer {
    D{i:1;anchors_x:8}D{i:3;anchors_width:400;anchors_x:0}
}
 ##^##*/
