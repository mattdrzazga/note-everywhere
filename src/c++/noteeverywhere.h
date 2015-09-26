#ifndef NOTEEVERYWHERE_H
#define NOTEEVERYWHERE_H

#include <QObject>
#include "notevalues.h"
#include "notemodel.h"
#include "sqlnoteinterface.h"

class NoteEverywhere : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal ratio READ ratio CONSTANT)
    Q_PROPERTY(NoteValues::Category category READ category WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(NoteModel* model READ model NOTIFY modelChanged)

public:
    explicit NoteEverywhere(QObject *parent = 0);

    inline qreal ratio() const { return m_ratio; }
    inline bool isMobile() const { return m_isMobile; }
    inline NoteValues::Category category() const { return m_category; }
    inline NoteModel* model() const { return m_model; }
    void setCategory(const NoteValues::Category &category);

signals:
    void categoryChanged(NoteValues::Category);
    void modelChanged();

public slots:

private:
    qreal m_ratio;
    bool m_isMobile;
    NoteValues::Category m_category;
    NoteModel *m_model;
    SqlNoteInterface sqlInterface;
};

#endif // NOTEEVERYWHERE_H
