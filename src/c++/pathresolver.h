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

signals:

public slots:
};

#endif // PATHRESOLVER_H
