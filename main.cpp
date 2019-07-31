#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QIcon>

#include "mnoteshandler.h"
#include "mnotesnetwork.h"
#include "mnotesconfig.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<MNotesHandler>("de.bibuweb.mnotes",1,0,"MNotesHandler");


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(QPixmap("qrc:/images/notes.png")));

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    QQmlContext *context = new QQmlContext(engine.rootContext());
    QQmlComponent component(&engine,url);


    MNotesHandler mnotes;
    MNotesNetwork network;
    MnotesConfig config;

    context->setContextProperty("document",&mnotes);
    context->setContextProperty("netWork",&network);
    context->setContextProperty("configData",&config);

    QObject *appWindow = component.create(context);
    mnotes.setTextObject(appWindow);

    QObject::connect(appWindow,SIGNAL(searchSignal(QString, QString)),&mnotes,SLOT(searchSignal(QString, QString)));
    QObject::connect(appWindow,SIGNAL(findNext()),&mnotes,SLOT(findNext()));

    return app.exec();
}
