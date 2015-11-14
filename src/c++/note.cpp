#include "note.h"
#include <QDebug>

Note::Note(QObject *parent):
    QObject(parent),
    m_id(-1),
    m_name(QString()),
    m_content(QString()),
    m_category(NoteValues::NONE)
{

}

Note::Note(const QString &name, const QString &content):
    QObject(0),
    m_id(-1),
    m_name(name),
    m_content(content),
    m_category(NoteValues::NONE)
{

}

Note::Note(const Note &note):
    QObject(0),
    m_id(note.m_id),
    m_name(note.m_name),
    m_content(note.m_content),
    m_category(note.m_category)
{

}

Note::~Note()
{

}

void Note::setName(const QString &name)
{
    if (m_name != name){
        m_name = name;
        emit nameChanged(m_name);
    }
}

void Note::setContent(const QString &content)
{
    if (m_content != content){
        m_content=content;
        emit contentChanged(m_content);
    }
}

void Note::setId(int id)
{
    if (m_id != id){
        m_id = id;
        emit idChanged(m_id);
    }
}

void Note::setCategory(const NoteValues::Category &category)
{
    if (m_category != category){
        m_category = category;
        emit categoryChanged(m_category);
    }
}

void Note::setLastModificationDateTime(const QDateTime &dateTime)
{
    if (m_lastModificationDateTime != dateTime){
        m_lastModificationDateTime = dateTime;
        emit lastModificationDateTimeChanged(m_lastModificationDateTime);
    }
}
