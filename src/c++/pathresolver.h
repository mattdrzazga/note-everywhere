#ifndef PATHRESOLVER_H
#define PATHRESOLVER_H

#include <QObject>

class PathResolver : public QObject
{
    Q_OBJECT
public:
    explicit PathResolver(QObject *parent = 0);
    Q_INVOKABLE QString iconPath(const QString &iconName);

signals:

public slots:
};

#endif // PATHRESOLVER_H
