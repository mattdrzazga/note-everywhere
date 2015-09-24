#include "note.h"
#include <QDebug>

Note::Note(QObject *parent) : QObject(parent)
{
}

Note::Note(const QString &name, const QString &content):
    m_name(name),
    m_content(content)
{
}

Note::Note(const Note &note):
    QObject(0)
{
    m_id = note.m_id;
    m_name = note.m_name;
    m_content = note.m_content;
    m_color = note.m_color;
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

void Note::setColor(const QString &color)
{
    if (m_color != color){
        m_color = color;
        emit colorChanged(m_color);
    }
}

void Note::setLastModificationDateTime(const QDateTime &dateTime)
{
    if (m_lastModificationDateTime != dateTime){
        m_lastModificationDateTime = dateTime;
        emit lastModificationDateTimeChanged(m_lastModificationDateTime);
    }
}
