#include "notevalues.h"

NoteValues::NoteValues(QObject *parent) : QObject(parent)
{

}

void NoteValues::registerEnums()
{
    qmlRegisterType<NoteValues>("NoteEverywhere", 1, 0, "Ne");
}

