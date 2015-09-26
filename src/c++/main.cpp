#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QQmlContext>
#include "pathresolver.h"
#include "noteeverywhere.h"
#include "notevalues.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    PathResolver pathResolver;
    NoteEverywhere noteEverywhere;
    NoteValues::registerEnums();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("PathResolver", &pathResolver);
    engine.rootContext()->setContextProperty("NoteEverywhere", &noteEverywhere);
    qmlRegisterType<Note>();
    engine.load(QUrl(QStringLiteral("qrc:/src/qml/main.qml")));

    return app.exec();
}

