import QtQuick 2.4
import QtQuick.Controls 2.12

Rectangle {
    id: notifierForm
    width: 400
    height: 120
    property alias notifierForm: notifierForm
    property alias label: label

    color: "#ebebeb"
    radius: 10

    Label {
        id: label
        x: 64
        y: 26
        width: 278
        height: 20
        text: qsTr("Label")
        anchors.verticalCenter: parent.verticalCenter
    }
}
