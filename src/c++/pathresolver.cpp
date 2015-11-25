#include "pathresolver.h"
#include <QDebug>
#include <QFile>
#include <QResource>

PathResolver::PathResolver(QObject *parent) : QObject(parent)
{

}

QString PathResolver::iconPath(const QString &iconName) const
{
#ifdef Q_OS_LINUX
    QString possiblePath = "qrc:/linux/images/linux/" + iconName + ".%1";
    return possiblePath.arg("png");
#else
    return "";
#endif
}
