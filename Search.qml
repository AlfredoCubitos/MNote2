import QtQuick 2.12

SearchFormular {
    id: search

    property alias search: search
    property string objName
    state: "hidden"
    height: 0
    opacity: 0.1
    width: parent.width
    visible: false
    anchors.bottom: parent.bottom

    textInput.text: textInput.activeFocus ? "" : qsTr("Search String")
    textInput.color: textInput.activeFocus ? "0000": "#aba6a6"


    textInput.onEditingFinished: {
       // console.log("edtingFinished " + objName)
        searchString = textInput.text
        searchSignal(textInput.text, objName)

        if (search.visible || search.activeFocus){
            textInput.text = searchString.length > 0 ? searchString  : qsTr("Search String")
        }
    }

    states: [
        State {
            name: "visible"
            PropertyChanges { target: search; visible: true; }
        },
        State {
            name: "hidden"
            PropertyChanges { target: search; visible: false }
        }
    ]
    transitions: [
        Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
                NumberAnimation{ target: search; property: "height"; to: 40; duration: 300}
                NumberAnimation{ target: search; property: "opacity"; to: 1.0; duration: 300}
            }
        },
        Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
                NumberAnimation{ target: search; property: "height"; to: 0.0; duration: 500}
                NumberAnimation{ target: search; property: "opacity"; to: 0.1; duration: 300}

            }
        }
    ]


}