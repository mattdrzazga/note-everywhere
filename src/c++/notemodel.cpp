#include "notemodel.h"
#include <QDebug>

NoteModel::NoteModel(QObject *parent):
    QAbstractListModel(parent)
{

}

NoteModel::~NoteModel()
{

}

void NoteModel::addNote(int id, const QString &name, const QString &content, int category, const QDateTime &dateTime)
{
    Note *note = new Note(this);
    note->setId(id);
    note->setName(name);
    note->setContent(content);
    note->setCategory(NoteValues::Category(category));
    note->setLastModificationDateTime(dateTime);
    addNote(note);
}

void NoteModel::removeNote(int index)
{
    if (index >= 0 && index < rowCount()){
        beginRemoveRows(QModelIndex(), index, index);
        delete m_notes.takeAt(index);
        endRemoveRows();
        emit sizeChanged();
    }
}

Note *NoteModel::getNote(int index)
{
    if (index >= 0 && index < rowCount()){
        return m_notes[index];
    }
    return NULL;
}

void NoteModel::clearModel()
{
    qDeleteAll(m_notes);
    beginRemoveRows(QModelIndex(), 0, rowCount());
    m_notes.clear();
    endRemoveRows();
    emit sizeChanged();
}

void NoteModel::setIdAt(int index, int id)
{
    if (index >= 0 && index < m_notes.count()){
        m_notes[index]->setId(id);
        dataChanged(this->index(index), this->index(index));
    }
}

void NoteModel::setNameAt(int index, const QString &name)
{
    if (index >= 0 && index < m_notes.count()){
        m_notes[index]->setName(name);
        dataChanged(this->index(index), this->index(index));
    }
}

void NoteModel::setContentAt(int index, const QString &content)
{
    if (index >= 0 && index < m_notes.count()){
        m_notes[index]->setContent(content);
        dataChanged(this->index(index), this->index(index));
    }
}

void NoteModel::setCategoryAt(int index, int category)
{
    if (index >= 0 && index < m_notes.count()){
        m_notes[index]->setCategory(NoteValues::Category(category));
        dataChanged(this->index(index), this->index(index));
    }
}

void NoteModel::setLastModificationDateTimeAt(int index, const QDateTime &dateTime)
{
    if (index >= 0 && index < m_notes.count()){
        m_notes[index]->setLastModificationDateTime(dateTime);
        dataChanged(this->index(index), this->index(index));
    }
}

void NoteModel::addNote(Note *note)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_notes << note;
    note->setParent(this);
    endInsertRows();
    emit sizeChanged();
}

int NoteModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_notes.count();
}

QVariant NoteModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_notes.count())
        return QVariant();

    const Note *note = m_notes[index.row()];
    if (role == IdRole)
        return note->id();
    else if (role == NameRole)
        return note->name();
    else if (role == ContentRole)
        return note->content();
    else if (role == CategoryRole)
        return note->category();
    else if (role == LastModificationRole)
        return note->lastModificationDateTime();

    return QVariant();
}

QHash<int, QByteArray> NoteModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[ContentRole] = "content";
    roles[CategoryRole] = "category";
    roles[LastModificationRole] = "lastModificationDateTime";
    return roles;
}
