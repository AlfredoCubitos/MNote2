import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

Rectangle {
    width: 400
    height: 400
    color: "#e4e440"
    property alias textArea: textArea
    visible: false
    ScrollView {
        id: scrollView
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOn

        TextArea {
            id: textArea
            objectName: "noteText"
            visible: true
            selectByMouse: true

        }
    }
}
