#ifndef NOTEMODEL_H
#define NOTEMODEL_H

#include <QAbstractListModel>
#include "note.h"
#include "notevalues.h"

class NoteModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int size READ size NOTIFY sizeChanged)

public:
    NoteModel(QObject *parent = 0);
    virtual ~NoteModel();
    inline int size() const { return m_notes.size(); }

    enum NoteRoles{
        IdRole = Qt::UserRole + 1,
        NameRole,
        ContentRole,
        CategoryRole,
        LastModificationRole
    };

    void addNote(Note *note);
    Q_INVOKABLE void addNote(int id, const QString &name, const QString &content, const NoteValues::Category &category, const QDateTime &dateTime);
    Q_INVOKABLE void removeNote(int index);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    Q_INVOKABLE Note *getNote(int index);
    void clearModel();

    Q_INVOKABLE void setIdAt(int index, int id);
    Q_INVOKABLE void setNameAt(int index, const QString &name);
    Q_INVOKABLE void setContentAt(int index, const QString &content);
    Q_INVOKABLE void setCategoryAt(int index, const NoteValues::Category &category);
    Q_INVOKABLE void setLastModificationDateTimeAt(int index, const QDateTime &dateTime);

signals:
    void sizeChanged();

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Note *> m_notes;
};

#endif // NOTEMODEL_H
