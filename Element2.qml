import QtQuick 2.12
import QtQuick.Dialogs 1.2
import QtQuick.LocalStorage 2.13
import "nextnote.js" as NN

ElementForm{
    id: element

    property alias element: element
    title: name
    property int indexId: nId
    property int listIndex
    property var data
    width: page.width

    mouseArea.onClicked: {

        if (!addButton)
        {
            NN.getNote(indexId)
            note.indexId = indexId
            stackView.push(note)
            addButton = true
            label.readOnly = false
            note.textArea.focus = true
            note.textArea.cursorVisible = true
        }

    }

    delButton.onClicked: {
        delDialog.visible = true

    }



     MessageDialog{
         id: delDialog
         visible: false
         title: qsTr("Warning!")
         icon: StandardIcon.Critical
         informativeText: qsTr("Realy want to delete?")
         standardButtons: StandardButton.Ok | StandardButton.Cancel
         onAccepted: {
             NN.delNote(indexId)
             elementModel.remove(index)
             console.log(index+" : "+indexId)
         }
     }
}
