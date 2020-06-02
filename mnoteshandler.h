#ifndef MNOTES_H
#define MNOTES_H

#include <QObject>
#include <QQuickTextDocument>
#include <QSyntaxHighlighter>


class MNotesHandler : public QObject
{
    Q_OBJECT


public:
    explicit MNotesHandler();

    void highLighter(const QString &search);

  //  QQuickItem *target() { return m_target; }

    Q_INVOKABLE QVariantList curpos() { return cur_pos; }

    void getTextDocument(QString objName);
    void setTextObject(QObject *obj);

private:
    QObject *textObject;
    QObject *App;
    QTextDocument *d_mnote;
    QQuickItem *m_target;
    bool isFirstTime;
    QString m_text;
    int m_curpos = 0;
    QQuickItem *sItem;
    void clearHighlight();

     QVariantList cur_pos;

     void countMethods(QObject *obj);


signals:

Q_SIGNALS:
  //  void targetChanged();
  //  void textChanged();
    void curposChanged( const char *fn, QObject* = nullptr);

public slots:
    void searchSignal(const QString &str, const QString &objName);
    void findNext();


};

#endif // MNOTES_H
