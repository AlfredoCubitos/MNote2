#include "mnoteshandler.h"
#include <QQuickItem>
#include <QDebug>
#include <QtQml>
#include <QTextCharFormat>
#include <QTextCursor>



#define BGCOLOR "#FFEBCD"


MNotesHandler::MNotesHandler()
{

}

void MNotesHandler::setTextObject(QObject *obj){
    textObject = obj;
}

void MNotesHandler::getTextDocument(QString objName){
    QObject *doc = textObject->findChild<QObject*>(objName);

     m_target = qobject_cast<QQuickItem*>(doc);
     bgcolor = m_target->parent()->property("color").value<QColor>().name();
}

/**
 * @brief MNotesHandler::highLighter
 * @param search
 *
 * Perfomes a search in a Note a highlights the words found
 */

void MNotesHandler::highLighter(const QString &search)
{
    if (! d_mnote)
        return;

//qDebug() << "search " << search;

    QTextCursor highlightCursor = QTextCursor(d_mnote);
    QTextCursor cursor = QTextCursor(d_mnote);



    if (d_mnote->availableUndoSteps() > 0)
    {
        // qDebug()<<"undo pos: "<<d_mnote->isUndoAvailable() << "steps: " << d_mnote->availableUndoSteps() ;

        clearHighlight();

    }

    cursor.beginEditBlock();
    QTextCharFormat plainFormat(highlightCursor.charFormat());
    QTextCharFormat colorFormat = plainFormat;

    colorFormat.setBackground(QColor(BGCOLOR));



    while (!highlightCursor.isNull() && !highlightCursor.atEnd()) {
        highlightCursor = d_mnote->find(search, highlightCursor);

        if (!highlightCursor.isNull()) {

            cur_pos.append(highlightCursor.position());

            highlightCursor.movePosition(QTextCursor::EndOfWord,  QTextCursor::KeepAnchor);
            highlightCursor.mergeCharFormat(colorFormat);
        }

    }

    cursor.endEditBlock();

}
/**
 * @brief MNotesHandler::clearHighlight
 *
 * clears the higlighted words from previous search
 */

void MNotesHandler::clearHighlight()
{
    QTextCursor cursor = QTextCursor(d_mnote);
    QTextCharFormat colorFormat;
    colorFormat.setBackground(QColor(bgcolor));
     while (!cursor.isNull() && !cursor.atEnd()) {
         cursor.movePosition(QTextCursor::WordRight);
         cursor.mergeCharFormat(colorFormat);
     }
}




/**********************
 * SLOTS
 * ********************/


/**
 * @brief SLOT: MNotesHandler::searchSignal
 * @param str
 */
void MNotesHandler::searchSignal(const QString &str, const QString &objName)
{

    getTextDocument(objName);
    if (!m_target)
        return;

    QVariant doc = m_target->property("textDocument");
    if (doc.canConvert<QQuickTextDocument*>()) {
        QQuickTextDocument *qqdoc = doc.value<QQuickTextDocument*>();
        if (qqdoc)
        {
            d_mnote = qqdoc->textDocument();
            highLighter(str);
        }
    }
}

void MNotesHandler::findNext()
{
    if (cur_pos.size() == 0)
        return;

    QTextCursor cursor(d_mnote);


    for (int i = 0; i< cur_pos.size();++i)
    {
       // qDebug() << cur_pos.at(i) << ":: " << m_curpos;
        if (cur_pos.at(i) > m_curpos)
        {
             cursor.setPosition(cur_pos.at(i).toInt());
             m_curpos = cursor.position(); //save cursor position which is at end of word

            //move cursor to begin of word -> curpos changes
             cursor.movePosition(QTextCursor::StartOfWord,QTextCursor::MoveAnchor);
             m_target->setProperty("cursorPosition",cursor.position());
             //set position back
             cursor.setPosition(m_curpos);
           // qDebug() << cur_pos.at(i) << " " << cursor.position() ;

            break;
        }

        if (i == cur_pos.size()-1)
            m_curpos = 0;

    }


}


/*********************
 * Debug functions
 * *******************/

/**
 * @brief MNotesHandler::countMethods for debugging only
 * @param pointer to a QObject
 *  note: if the object is not valid the program compiles but crashes without error message
 *
 * Check the methods available in an object
 *
 */
void MNotesHandler::countMethods(QObject *obj)
{
    const QMetaObject* metaObject = obj->metaObject();

    if (metaObject->methodOffset() > 0)
    {
        for(int i = metaObject->methodOffset(); i < metaObject->methodCount(); ++i)
            qDebug() << QString::fromLatin1(metaObject->method(i).methodSignature());
    }else{
        qDebug() << obj->objectName() << "no Methods found";
    }
}
