#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QQmlContext>
#include "pathresolver.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    PathResolver pathResolver;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("PathResolver", &pathResolver);
    engine.load(QUrl(QStringLiteral("qrc:/src/qml/main.qml")));

    return app.exec();
}

