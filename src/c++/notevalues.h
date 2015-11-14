#ifndef NOTEVALUES_H
#define NOTEVALUES_H

#include "QObject"
#include <QtQml>

class NoteValues : public QObject
{
    Q_OBJECT
public:
    explicit NoteValues(QObject *parent = 0);

    enum Category {
        WORK,
        ENTERTAINMENT,
        HOBBY,
        HOME,
        NONE
    };
    Q_ENUM(Category)

    static void registerEnums();
};

#endif // NOTEVALUES_H
