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
    Q_PROPERTY(NoteValues::Category currentCategory READ currentCategory WRITE setCurrentCategory NOTIFY currentCategoryChanged)
    Q_PROPERTY(NoteModel* model READ model NOTIFY modelChanged)
    Q_PROPERTY(SqlNoteInterface* sqlInterface READ sqlInterface CONSTANT)
    Q_PROPERTY(Note* currentNote READ currentNote WRITE setCurrentNote NOTIFY currentNoteChanged)
    Q_PROPERTY(Note* previousNote READ previousNote NOTIFY previousNoteChanged)

public:
    explicit NoteEverywhere(QObject *parent = 0);

    inline qreal ratio() const { return m_ratio; }
    inline bool isMobile() const { return m_isMobile; }
    inline NoteValues::Category currentCategory() const { return m_currentCategory; }
    inline NoteModel* model() const { return m_model; }
    inline SqlNoteInterface* sqlInterface() const { return m_sqlInterface; }
    inline Note* currentNote() const { return m_currentNote; }
    inline Note* previousNote() const { return m_previousNote; }
    void setCurrentCategory(const NoteValues::Category &category);
    void setCurrentNote(Note *currentNote);

    Q_INVOKABLE void populateModel();
    Q_INVOKABLE void notesFor(const QString &text);

signals:
    void currentCategoryChanged(NoteValues::Category);
    void modelChanged();
    void currentNoteChanged();
    void previousNoteChanged();

public slots:

private:
    qreal m_ratio;
    bool m_isMobile;
    NoteValues::Category m_currentCategory;
    NoteModel *m_model;
    SqlNoteInterface *m_sqlInterface;
    Note *m_currentNote;
    Note *m_previousNote;
};

#endif // NOTEEVERYWHERE_H
