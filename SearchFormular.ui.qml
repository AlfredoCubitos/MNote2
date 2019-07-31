import QtQuick 2.4
import QtQuick.Controls 2.5

Rectangle {
    id: rectangle
    width: 400
    height: 400
    color: "#e4e0e0"

    property alias textInput: textInput

    Label {
        id: label
        text: qsTr("Search: ")
        anchors.left: parent.left
        anchors.leftMargin: 17
        anchors.top: parent.top
        anchors.topMargin: 14
    }

    Rectangle {
        id: rectangle1
        x: 8
        y: 0
        border.color: "gray"
        width: 170
        height: 20
        anchors.left: parent.left
        anchors.leftMargin: 71
        anchors.top: parent.top
        anchors.topMargin: 14

        TextInput {
            id: textInput
            width: 170
            height: 20
            color: "#aba6a6"
            anchors.left: parent.left
            anchors.leftMargin: 3

            font.pixelSize: 12
        }
    }
}




/*##^## Designer {
    D{i:1;anchors_x:17;anchors_y:14}D{i:2;anchors_x:71;anchors_y:14}
}
 ##^##*/
