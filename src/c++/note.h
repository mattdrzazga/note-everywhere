#ifndef NOTE_H
#define NOTE_H

#include <QObject>
#include <QDateTime>
#include "notevalues.h"

class Note : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)
    Q_PROPERTY(NoteValues::Category category READ category WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(QDateTime lastModificationDateTime READ lastModificationDateTime WRITE setLastModificationDateTime NOTIFY lastModificationDateTimeChanged)

public:
    explicit Note(QObject *parent = 0);
    Note(const QString &name, const QString &content);
    Note(const Note &note);
    virtual ~Note();

    inline int id() const { return m_id; }
    inline QString name() const { return m_name; }
    inline QString content() const { return m_content; }
    inline NoteValues::Category category() const { return m_category; }
    inline QDateTime lastModificationDateTime() const { return m_lastModificationDateTime; }

signals:
    void idChanged(int id);
    void nameChanged(const QString &name);
    void contentChanged(const QString &content);
    void categoryChanged(const NoteValues::Category &category);
    void lastModificationDateTimeChanged(const QDateTime &dateTime);

public slots:
    void setId(int id);
    void setName(const QString &name);
    void setContent(const QString &content);
    void setCategory(const NoteValues::Category &category);
    void setLastModificationDateTime(const QDateTime &dateTime);

private:
    int m_id;
    QString m_name;
    QString m_content;
    NoteValues::Category m_category;
    QDateTime m_lastModificationDateTime;
};

#endif // NOTE_H
