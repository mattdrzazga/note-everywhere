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

QString PathResolver::categoryIcon(int category) const
{
    switch (category) {
    case NoteValues::WORK:
        return "qrc:/linux/images/linux/flag-red.svg";
        break;
    case NoteValues::ENTERTAINMENT:
        return "qrc:/linux/images/linux/flag-blue.svg";
        break;
    case NoteValues::HOBBY:
        return "qrc:/linux/images/linux/flag-green.svg";
        break;
    case NoteValues::HOME:
        return "qrc:/linux/images/linux/flag-yellow.svg";
        break;
    case NoteValues::NONE:
        return "qrc:/linux/images/linux/flag-grey.svg";
        break;
    default:
        return "qrc:/linux/images/linux/flag-grey.svg";
        break;
    }
}
