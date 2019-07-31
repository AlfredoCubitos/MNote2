import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: elementForm

    property alias title: title.text
    property alias mouseArea: mouseArea
    property int indexId
    property alias delButton: delButton

    x: 0
    y: 0
    // width: page.width
    width: 400
    height: 45
    color: "#e1d83a"

    gradient: Gradient {
        GradientStop {
            position: 0.013
            color: "#e1d83a"
        }

        GradientStop {
            position: 0.57
            color: "#d9cf21"
        }

        GradientStop {
            position: 1
            color: "#a59e2d"
        }
    }

    Label {
        id: title
        x: 19
        y: 13
        width: 119
        height: 18
        text: qsTr("Label")
    }

    MouseArea {
        id: mouseArea

        width: parent.width - delButton.width - delButton.anchors.rightMargin - 10
        height: 43
    }

    Button {
        id: delButton

        width: 42
        height: 40
        focusPolicy: Qt.ClickFocus
        enabled: true
        anchors.rightMargin: 25
        anchors.right: parent.right
        icon.color: 'transparent'
        icon.source: "images/delete.png"
        leftPadding: 7
        opacity: 1

        background.opacity: 0
    }
}
