import QtQuick 2.4

NotifierFormular {
    id: notifier

    property alias notifier: notifier
    property string info: ""

    state: "hidden"
    height: 4
    opacity: 0.1
    width: parent.width
    visible: false

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    label.text: info

    states: [
        State {
            name: "visible"
            PropertyChanges { target: notifier; visible: true; }
        },
        State {
            name: "hidden"
            PropertyChanges { target: notifier; visible: false }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
                NumberAnimation{ target: notifier; property: "height"; to: 60; duration: 500}
                NumberAnimation{ target: notifier; property: "opacity"; to: 1.0; duration: 300}
                PropertyAnimation{ target: notifier; property: "state"; to: "hidden"; duration: 3000}

            }

        }
    ]

 }
