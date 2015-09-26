#ifndef SQLNOTEMODEL_H
#define SQLNOTEMODEL_H

#include <QtSql/QSqlQueryModel>
#include <QList>
#include "note.h"
#include "notemodel.h"

class SqlNoteInterface : public QObject
{
    Q_OBJECT
public:
    SqlNoteInterface(QObject *parent = 0);
    ~SqlNoteInterface();

    Q_INVOKABLE NoteModel* populateModel() const;
    Q_INVOKABLE int addNote(const QString &name,
                            const QString &content,
                            int category,
                            const QDateTime &lastModificationDateTime = QDateTime::currentDateTime()) const;
    Q_INVOKABLE bool updateNote(int id, const QString &name, const QString &content) const;
    Q_INVOKABLE bool updateNoteContent(int id, const QString &content) const;
    Q_INVOKABLE bool updateNoteName(int id, const QString &name) const;
    Q_INVOKABLE bool updateNoteCategory(int id, int category) const;
    Q_INVOKABLE bool updateNoteLastModificationDateTime(int id, const QDateTime &dateTime) const;
    Q_INVOKABLE bool deleteNote(int id) const;
    //    Q_INVOKABLE void searchForStringAndColor(const QString &text, const QString &color)const;
    //    Q_INVOKABLE void searchForString(const QString &text)const;
    //    Q_INVOKABLE void searchForColor(const QString &color)const;
};

#endif // SQLNOTEMODEL_H
