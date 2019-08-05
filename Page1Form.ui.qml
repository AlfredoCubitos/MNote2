import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.LocalStorage 2.12

Page {
    id: page

    // width: appWindow.width
    // height: appWindow.height
    width: 400
    font.pixelSize: 12

    property alias page: page
    property alias p1Button: button
    property bool addButton: false
    property alias listView: listView
    property alias stackView: stackView
    property alias note: note
    property alias elementModel: elementModel
    property alias label: label

    header: Frame {
        id: frame
        x: 0
        width: parent.width
        height: 51
        anchors.top: parent.top
        anchors.topMargin: 0

        background: Rectangle {
            color: "#d0d0d0"
        }

        Button {
            id: button
            x: 521
            y: -7
            width: 40
            height: 40

            icon.source: addButton ? "images/go-previous.png" : "images/list.png"
            anchors.right: parent.right
            anchors.rightMargin: 15
            spacing: 4
        }

        TextField {
            id: label
            x: 180
            y: 4
            width: 170
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: button.verticalCenter
            placeholderText: qsTr("Add New")
            font.pointSize: 11
            readOnly: true
            background: Rectangle {
                color: label.readOnly ? "transparent" : "#ece09a"
            }
        }
    }
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: listView
    }

    ListModel {
        id: elementModel
    }

    ListView {
        id: listView
        model: elementModel
        delegate: Element {
            id: element
        }
    }

    Note {
        id: note

    }
}
