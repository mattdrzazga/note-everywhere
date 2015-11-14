#ifndef PATHRESOLVER_H
#define PATHRESOLVER_H

#include <QObject>
#include "notevalues.h"

class PathResolver : public QObject
{
    Q_OBJECT
public:
    explicit PathResolver(QObject *parent = 0);
    Q_INVOKABLE QString iconPath(const QString &iconName) const;
    Q_INVOKABLE QString categoryIcon(int category) const;

    Q_INVOKABLE inline static QString appLocalDataLocation() {
        QString path = QStandardPaths::standardLocations(QStandardPaths::AppLocalDataLocation).value(0);
        QDir dir(path);
        if (!dir.exists())
            dir.mkpath(path);
        if (!path.isEmpty() && !path.endsWith("/"))
            path += "/";
        return path;
    }
};

#endif // PATHRESOLVER_H
