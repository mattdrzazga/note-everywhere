#ifndef PATHRESOLVER_H
#define PATHRESOLVER_H

#include <QObject>

class PathResolver : public QObject
{
    Q_OBJECT
public:
    explicit PathResolver(QObject *parent = 0);

signals:

public slots:
};

#endif // PATHRESOLVER_H
