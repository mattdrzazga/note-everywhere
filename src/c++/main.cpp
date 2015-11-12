#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QQmlContext>
#include "pathresolver.h"
#include "noteeverywhere.h"
#include "notevalues.h"
#include "textformatter.h"

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
    qmlRegisterType<TextFormatter>("NoteEverywhere", 1, 0, "TextFormatter");

    engine.load(QUrl(QStringLiteral("qrc:/src/qml/main.qml")));

    return app.exec();
}

