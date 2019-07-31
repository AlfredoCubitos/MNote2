import QtQuick 2.12
import QtQuick.Dialogs 1.2
import QtQuick.LocalStorage 2.13
import "backend.js" as DB

ElementForm{
    id: element

    property alias element: element
    title: name
    property int indexId: nId
    property int listIndex
    width: page.width

    mouseArea.onClicked: {

        if (!addButton)
        {
            var data = DB.getNoteData(indexId)
            label.text = data.name ? data.name : "Add New"
            note.textArea.text = data.content
            note.indexId = indexId
            stackView.push(note)
            addButton = true
            label.readOnly = false
            note.textArea.focus = true
            note.textArea.cursorVisible = true
            note.textArea.selectionStart = 1
        }

    }

    delButton.onClicked: {
        delDialog.visible = true

    }

    Component.onCompleted: {
      DB.initDB()

    }

     MessageDialog{
         id: delDialog
         visible: false
         title: qsTr("Warning!")
         icon: StandardIcon.Critical
         informativeText: qsTr("Realy want to delete?")
         standardButtons: StandardButton.Ok | StandardButton.Cancel
         onAccepted: {
             DB.deleteNote(indexId)
             elementModel.remove(index)
             console.log(index+" : "+indexId)
         }
     }
}
