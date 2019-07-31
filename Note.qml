import QtQuick 2.12
import QtQuick.Controls 2.12
import org.kde.prison 1.0 as Prison
//import de.bibuweb.mnotes 1.0
NoteFormular {

  //  property alias note: note
    id: note

    property int indexId
    property string noteObjName: textArea.objectName
    property alias qrcode: qrcode
    anchors.fill: parent
    Accessible.name: "mnotesHandler"

    textArea.persistentSelection: true

    textArea.onPressed: {
        console.log(event.button)
        if (event.button === Qt.RightButton && textArea.selectedText.length > 0)
        {
            console.log(textArea.selectedText)
            popup.x = event.x
            popup.y = event.y
            qrcode.open()
        }
    }

    Popup{
        id: popup
    //    closePolicy: Popup.CloseOnReleaseOutside
        padding: 10
        contentItem: Image {
            id: popupImage
            source: "qrc:/images/qrcode.png"
        }
    }

    Popup{
        id: qrcode
        width: appWindow.width - 4
        height: width
        anchors.centerIn: Overlay.overlay
        contentItem: Prison.Barcode{
            anchors.fill: parent
            content: textArea.selectedText
            barcodeType: "QRCode"
        }
    }

}

