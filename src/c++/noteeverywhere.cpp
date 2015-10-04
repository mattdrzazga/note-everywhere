#include "noteeverywhere.h"
#include <QGuiApplication>
#include <QScreen>
#include <QDebug>

NoteEverywhere::NoteEverywhere(QObject *parent) : QObject(parent), m_model(0), m_currentNote(0) //TODO check if crash persists when not initializing m_currentNote
{
    m_isMobile = false;
#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(Q_OS_BLACKBERRY)
    m_isMobile = true;
#endif

    QRect rect = qApp->primaryScreen()->geometry();
    m_ratio = m_isMobile ? qMin(qMax(rect.width(), rect.height())/1136. , qMin(rect.width(), rect.height())/640.) : 1;
    m_currentCategory = NoteValues::NONE;

    m_sqlInterface = new SqlNoteInterface(this);
}

void NoteEverywhere::setCurrentCategory(const NoteValues::Category &category)
{
    if (m_currentCategory != category){
        m_currentCategory = category;
        emit currentCategoryChanged(m_currentCategory);
    }
}

void NoteEverywhere::setCurrentNote(Note *currentNote)
{
    if (m_currentNote != currentNote){
        m_currentNote = currentNote;
        emit currentNoteChanged();
    }
}

void NoteEverywhere::populateModel()
{
    m_model = m_sqlInterface->populateModel();
    emit modelChanged();
}

void NoteEverywhere::notesFor(const QString &text)
{
    m_model = m_sqlInterface->notesFor(text, m_currentCategory);
    emit modelChanged();
}
