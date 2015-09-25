#ifndef NOTEEVERYWHERE_H
#define NOTEEVERYWHERE_H

#include <QObject>

class NoteEverywhere : public QObject
{
    Q_OBJECT

public:
    explicit NoteEverywhere(QObject *parent = 0);

signals:

public slots:
};

#endif // NOTEEVERYWHERE_H
