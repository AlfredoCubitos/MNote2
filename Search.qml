import QtQuick 2.12

SearchFormular {
    id: search

    property alias search: search
    property string objName
    property var note

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
        searchSignal(searchString, objName)

        if (search.visible || search.activeFocus){
            textInput.text = searchString.length > 0 ? searchString  : qsTr("Search String")
        }
        if(document.curpos().length > 0)
        {
            if (document.curpos()[0] < note.length /2)
            {
                note.cursorPosition = note.length /2
                note.cursorPosition =  document.curpos()[0]
            }

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
                NumberAnimation{ target: search; property: "height"; to: 40; duration: 200}
                NumberAnimation{ target: search; property: "opacity"; to: 1.0; duration: 200}
            }
        },
        Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
                NumberAnimation{ target: search; property: "height"; to: 0.0; duration: 400}
                NumberAnimation{ target: search; property: "opacity"; to: 0.1; duration: 200}

            }
        }
    ]


}
