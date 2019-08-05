import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.2

import "nextnote.js" as NN

Page2Form {

    id: page2

    property string category:  "" // Category used by notes in Nextcloud
    property bool favorite: false // used by notes in Nextcloud
    property string request: ""  // add request type in nextnote.js
    property alias page2:  page2
    property alias search: search

    p2Button.onClicked: {
        var title
        if (addButton) /* < */
        {

            stackView.pop()
            label.readOnly = true
            if (newNote){
                elementModel.append({'name':label.text})

                NN.newNote(note.textArea.text)
                newNote = false
            }else{
                NN.updateNote(note.indexId, category, favorite, note.textArea.text)
            }
            label.text = "Add New"
            addButton = false

        }else{ /* + */
            newNote = true
            addButton = true
            label.readOnly = false

            label.placeholderText = "Note Title"
            stackView.push(note)
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
        delegate: Element2 {
            id: element
        }
    }



    Search{
        id: search
        objName: note.textArea.objectName
        note:  note.textArea
    }

    Note {
        id: note
        textArea.objectName: "noteText2"
    }
    BusyIndicator{
        id: notesBusy
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    Notifier{
        id: notif
      //  state:  "visible"
      //  visible: true
    }

    onFocusChanged: {
       // console.log("page2 " + page2.focus)
        if (page2.focus)
        {
            if (netWork.checkNetwork())
            {   notesBusy.visible = true;
                netWork.clearNetwork();
                netWork.initConnect(config.configTitle.text);
                netWork.resultAvailable.connect(NN.parseJson);
                NN.getList();
            }else{
                notif.info = "Network not available\n Please check your Network configuration"
                notif.state = "visible"
                notif.visible = true
            }
        }
    }


}

