#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "apimanager.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<ApiManager>("ApiManager",1,0,"ApiManager");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/NepaliCalendar/Main.qml"_qs);
    //const QUrl url(u"qrc:/NepaliCalendar/swipeTest.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
