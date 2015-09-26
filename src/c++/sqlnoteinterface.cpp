#include "sqlnoteinterface.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

SqlNoteInterface::SqlNoteInterface(QObject *parent):
    QObject(parent)
{
    QSqlDatabase db=QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("memory");
    if (!db.open()){
        qFatal("Cannot open db");
        return;
    }

    QSqlQuery query;
    query.exec("create table if not exists Notes(id INTEGER PRIMARY KEY AUTOINCREMENT, name Text, content Text, category TINYINT, lastModificationDateTime DATETIME )");
    populateModel();
}

SqlNoteInterface::~SqlNoteInterface()
{
}

NoteModel* SqlNoteInterface::populateModel() const
{
    QSqlQuery query("SELECT * FROM Notes");
    if (!query.exec())
        qFatal("Query failed");

    NoteModel *noteModel = new NoteModel();

    while (query.next()){
        Note *note = new Note();
        note->setId(query.value("id").toInt());
        note->setName(query.value("name").toString());
        note->setContent(query.value("content").toString());
        note->setCategory(NoteValues::Category(query.value("category").toInt()));
        noteModel->addNote(note);
    }

    return noteModel;
}

int SqlNoteInterface::addNote(const QString &name,
                              const QString &content,
                              const NoteValues::Category &category,
                              const QDateTime &lastModificationDateTime) const
{
    QSqlQuery query;
    query.prepare("insert into Notes(name, content, category, lastModificationDateTime) values (:name, :content, :category, :lastModificationDateTime)");
    query.bindValue(":name", name);
    query.bindValue(":content", content);
    query.bindValue(":category", category);
    query.bindValue(":lastModificationDateTime", lastModificationDateTime);

    if (query.exec())
        return query.lastInsertId().toInt();
    else
        return -1;
}

bool SqlNoteInterface::updateNote(int id, const QString &name, const QString &content) const
{
    QSqlQuery query;
    query.prepare("update Note set name = :name, content = :content where id = :id");
    query.bindValue(":id", id);
    query.bindValue(":name", name);
    query.bindValue(":content", content);

    return query.exec();
}

bool SqlNoteInterface::updateNoteName(int id, const QString &name) const
{
    QSqlQuery query;
    query.prepare("update Note set name = :name where id = :id");
    query.bindValue(":id", id);
    query.bindValue(":name", name);

    return query.exec();
}

bool SqlNoteInterface::updateNoteCategory(int id, const NoteValues::Category &category) const
{
    QSqlQuery query;
    query.prepare("update Note set category = :category where id = :id");
    query.bindValue(":id", id);
    query.bindValue(":category", category);

    return query.exec();
}

bool SqlNoteInterface::updateNoteLastModificationDateTime(int id, const QDateTime &dateTime) const
{
    QSqlQuery query;
    query.prepare("update Note set lastModificationDateTime = :lastModificationDateTime where id = :id");
    query.bindValue(":id", id);
    query.bindValue(":lastModificationDateTime", dateTime);

    return query.exec();
}


bool SqlNoteInterface::updateNoteContent(int id, const QString &content) const
{
    QSqlQuery query;
    query.prepare("update Note set content = :content where id = :id");
    query.bindValue(":id", id);
    query.bindValue(":content", content);

    return query.exec();
}

bool SqlNoteInterface::deleteNote(int id) const
{
    QSqlQuery query;
    query.prepare("DELETE FROM Note WHERE id = :id");
    query.bindValue(":id", id);

    return query.exec();
}
/*
void SqlNoteInterface::searchForStringAndColor(const QString &text, const QString &color) const
{
    if (!noteModel)
        return;

    QSqlQuery query;
    query.prepare("SELECT * FROM Note Where (name LIKE '%"+text+"%' or content LIKE '%"+text+"%') "+"AND color='"+color+"'");

    if (!query.exec())
        qFatal("Query failed");

    noteModel->clearModel();

    while (query.next()){
        Note *note = new Note();
        note->setId(query.value("id").toInt());
        note->setName(query.value("name").toString());
        note->setContent(query.value("content").toString());
//        note->setCategory(query.value("category").toInt());
        noteModel->addNote(note);
    }
}

void SqlNoteInterface::searchForString(const QString &text) const
{
    if (!noteModel)
        return;

    QSqlQuery query;
    query.prepare("SELECT * FROM Note WHERE content LIKE '%"+text+"%' or name LIKE '%"+text+"%'");

    if (!query.exec())
        qFatal("Query failed");

    noteModel->clearModel();

    while (query.next()){
        Note *note = new Note();
        note->setId(query.value("id").toInt());
        note->setName(query.value("name").toString());
        note->setContent(query.value("content").toString());
//        note->setCategory(query.value("category").toInt());
        noteModel->addNote(note);
    }
}

void SqlNoteInterface::searchForColor(const QString &color) const
{
    if (!noteModel)
        return;

    QSqlQuery query;
    query.prepare("SELECT * FROM Note WHERE color=:color");
    query.bindValue(":color", color);

    if (!query.exec())
        qFatal("Query failed");

    noteModel->clearModel();

    while (query.next()){
        Note *note = new Note();
        note->setId(query.value("id").toInt());
        note->setName(query.value("name").toString());
        note->setContent(query.value("content").toString());
//        note->setCategory(query.value("category").toInt());
        noteModel->addNote(note);
    }
}
*/
