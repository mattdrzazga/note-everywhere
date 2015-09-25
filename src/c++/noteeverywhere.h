#ifndef NOTEEVERYWHERE_H
#define NOTEEVERYWHERE_H

#include <QObject>
#include "notevalues.h"
#include "notemodel.h"

class NoteEverywhere : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal ratio READ ratio CONSTANT)
    Q_PROPERTY(NoteValues::Category category READ category WRITE setCategory NOTIFY categoryChanged)

public:
    explicit NoteEverywhere(QObject *parent = 0);

    qreal ratio() const { return m_ratio; }
    bool isMobile() const { return m_isMobile; }
    NoteValues::Category category() const { return m_category; }
    void setCategory(const NoteValues::Category &category);

signals:
    void categoryChanged(NoteValues::Category);

public slots:

private:
    qreal m_ratio;
    bool m_isMobile;
    NoteValues::Category m_category;
};

#endif // NOTEEVERYWHERE_H
