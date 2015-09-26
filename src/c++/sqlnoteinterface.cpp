#include "sqlnoteinterface.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include "pathresolver.h"

SqlNoteInterface::SqlNoteInterface(QObject *parent):
    QObject(parent)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    QString dbPath = PathResolver::appLocalDataLocation() + "notes";
    db.setDatabaseName(dbPath);
    if (!db.open()) {
        qFatal("Cannot open db");
        return;
    }

    QSqlQuery query;
    query.exec("create table if not exists Note(id INTEGER PRIMARY KEY AUTOINCREMENT, name Text, content Text, category TINYINT, lastModificationDateTime DATETIME )");
    populateModel();
}

SqlNoteInterface::~SqlNoteInterface()
{
}

NoteModel* SqlNoteInterface::populateModel() const
{
    QSqlQuery query("SELECT * FROM Note");
    return modelForQuery(query);
}

int SqlNoteInterface::addNote(const QString &name,
                              const QString &content,
                              int category,
                              const QDateTime &lastModificationDateTime) const
{
    QSqlQuery query;
    query.prepare("insert into Note(name, content, category, lastModificationDateTime) values (:name, :content, :category, :lastModificationDateTime)");
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

bool SqlNoteInterface::updateNoteCategory(int id, int category) const
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

NoteModel *SqlNoteInterface::notesFor(const QString &text, int category) const
{
    QSqlQuery query;

    if (text.isEmpty()) {
        if (category == NoteValues::NONE) {
            return populateModel();
        }
        else {
            query.prepare("SELECT * FROM note WHERE category = :category");
            query.bindValue(":category", category);
            return modelForQuery(query);
        }
    }
    else {
        if (category == NoteValues::NONE) {
            query.prepare("SELECT * FROM Note WHERE (name LIKE '%"+text+"%' or content LIKE '%"+text+"%')");
            return modelForQuery(query);
        }
        else {
            query.prepare("SELECT * FROM Note WHERE (name LIKE '%"+text+"%' OR content LIKE '%"+text+"%') "+"AND category = ':category'");
            query.bindValue(":category", category);
            return modelForQuery(query);
        }
    }
}

NoteModel *SqlNoteInterface::modelForQuery(QSqlQuery &query) const
{
    if (!query.exec())
        qFatal("Query failed");

    NoteModel *noteModel = new NoteModel();

    while (query.next()) {
        Note *note = new Note();
        note->setId(query.value("id").toInt());
        note->setName(query.value("name").toString());
        note->setContent(query.value("content").toString());
        note->setCategory(NoteValues::Category(query.value("category").toInt()));
        note->setLastModificationDateTime(query.value("lastModificationDateTime").toDateTime());
        noteModel->addNote(note);
    }

    return noteModel;
}
