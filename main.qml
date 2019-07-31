import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.2
import QtQuick.LocalStorage 2.13
//d_import org.kde.prison 1.0 as Prison

import de.bibuweb.mnotes 1.0

import "backend.js" as DB


/*use this import for Android
  * if not it throws "component not ready" error
*/
//import "qrc:/"

ApplicationWindow {

    id: appWindow
    visible: true
    width: 320
    height: 480
    title: qsTr("Tabs")

    //! [orientation]
    readonly property bool inPortrait: appWindow.width < appWindow.height
    //! [orientation]

    property alias appWindow: appWindow
    property bool newNote: false
    property string searchString


    signal searchSignal(string txt, string objName)
    signal findNext()


    header: ToolBar {

        ToolButton {
            implicitHeight: 22
            implicitWidth: 22
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            background: Image {
                source: "images/menu.png"
            }

            onClicked: toolbarMenu.popup()
        }
            Menu{
                id: toolbarMenu

                title: qsTr("Config")
                MenuItem{
                    text: "xxCloud"
                    onTriggered: {
                        config.visible = true
                    }
                }



            }
        }

    Drawer {
            id: drawer
            y: header.height + 51
            width: appWindow.width * 0.4
            height: appWindow.height - header.height - 81
            modal: inPortrait
            interactive: inPortrait
            position: inPortrait ? 0 : 1
            visible: !inPortrait
            Pane{
                anchors.fill: parent
                background: Rectangle{
                    color: "#d9d9d9"
                    gradient: Gradient {
                        GradientStop {
                            position: 0.42;
                            color: "#d9d9d9";
                        }
                        GradientStop {
                            position: 0.95;
                            color: "#ffffff";
                        }
                    }
                }
                Column{
                    spacing: 4
                    anchors.fill: parent
                MenuItem{
                    text: "Search"
                    icon.name: "lupe"
                    icon.source: "images/lupe.png"
                    width: parent.width
                    onTriggered: {
                        if (swipeView.currentItem.addButton )
                           swipeView.currentItem.search.state = swipeView.currentItem.search.state === "visible" ? "hidden" : "visible"
                        drawer.close()
                    }
                    background: Rectangle{
                        color: "#c8c8c5"
                        anchors.fill: parent

                    }
                }

                MenuItem{
                    text: "QR-Code"
                    icon.source: "images/qrcode.png"
                    width: parent.width
                    background: Rectangle{
                        color: "#c8c8c5"
                        anchors.fill: parent

                    }
                    onTriggered: {

                       // console.log(swipeView.currentItem.note.textArea.selectedText)

                        if (swipeView.currentItem.note.textArea.selectedText.length > 0)
                        {
                            swipeView.currentItem.note.qrcode.contentItem.content = swipeView.currentItem.note.textArea.selectedText
                            swipeView.currentItem.note.qrcode.open()
                        }


                    }
                }
                }

            }
        }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex


        Shortcut{
            sequence: StandardKey.Find
            onActivated:  {
                //console.log("Short: "+swipeView.currentItem.addButton + " " + swipeView.currentItem.objectName)

                if (swipeView.currentItem.addButton )
                   swipeView.currentItem.search.state = swipeView.currentItem.search.state === "visible" ? "hidden" : "visible"
                search.textInput.focus = true

            }
        }
        Shortcut{
            sequence: StandardKey.FindNext
            onActivated: {
                if (search.visible){
                    findNext()
                }
            }
        }

        Page1Form {
           id: page

           property alias page:  page
           property alias search: search

           p1Button.onClicked: {
               var title
               if (addButton) /* < */
               {

                   stackView.pop()
                   label.readOnly = true
                   if (newNote){
                       elementModel.append({'name':label.text})
                       DB.insertData(label.text,note.textArea.text)
                       newNote = false
                   }else{
                       DB.updateData(note.indexId,label.text,note.textArea.text)
                      // console.log("IndexId "+ label.text)
                   }
                   label.text = "Add New"

                   // console.log(note.textArea.text)

                   addButton = false
                   note.textArea.text = ""

               }else{ /* + */
                   newNote = true
                   addButton = true
                   label.readOnly = false

                   label.placeholderText = "Note Title"
                   stackView.push(note)
                   note.textArea.focus = true
                   note.textArea.cursorVisible = true
                   note.textArea.selectionStart = 1
               }

           }

           Search{
               id: search
           }

            Component.onCompleted:{
                var rows = DB.getTitels();
                for (var i =0; i<rows.length;i++)
                {
                    elementModel.append({"name":rows.item(i).titel,"nId":rows.item(i).id})
                   // console.log(rows.item(i).titel+" "+rows.item(i).id)

                }

                search.objName = note.textArea.objectName
            }



        }

        Page2 {
            id: page2

        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Note")
        }
        TabButton {
            text: qsTr("Cloud")
        }
    }

    Config{
        id: config
    }

    Component.onCompleted: DB.initDB()

}
