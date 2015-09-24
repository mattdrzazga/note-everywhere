#ifndef NOTE_H
#define NOTE_H

#include <QObject>
#include <QDateTime>

class Note : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)
    Q_PROPERTY(QString color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QDateTime lastModificationDateTime READ lastModificationDateTime WRITE setLastModificationDateTime NOTIFY lastModificationDateTimeChanged)

public:
    explicit Note(QObject *parent = 0);
    Note(const QString &name, const QString &content);
    Note(const Note &note);
    virtual ~Note();

    inline int id() const { return m_id; }
    inline QString name() const { return m_name; }
    inline QString content() const { return m_content; }
    inline QString color() const { return m_color; }
    inline QDateTime lastModificationDateTime() const { return m_lastModificationDateTime; }

signals:
    void idChanged(int id);
    void nameChanged(const QString &name);
    void contentChanged(const QString &content);
    void colorChanged(const QString &color);
    void lastModificationDateTimeChanged(const QDateTime &dateTime);

public slots:
    void setId(int id);
    void setName(const QString &name);
    void setContent(const QString &content);
    void setColor(const QString &color);
    void setLastModificationDateTime(const QDateTime &dateTime);

private:
    int m_id;
    QString m_name;
    QString m_content;
    QString m_color;
    QDateTime m_lastModificationDateTime;
};

#endif // NOTE_H
