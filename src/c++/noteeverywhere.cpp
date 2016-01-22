#include "noteeverywhere.h"
#include <QGuiApplication>
#include <QScreen>
#include <QDebug>

NoteEverywhere::NoteEverywhere(QObject *parent) : QObject(parent), m_model(0), m_currentNote(0), m_previousNote(0) //TODO check if crash persists when not initializing m_currentNote
{
    m_isMobile = false;
#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(Q_OS_BLACKBERRY)
    m_isMobile = true;
#endif

    QRect rect = qApp->primaryScreen()->geometry();
    m_ratio = m_isMobile ? qMin(qMax(rect.width(), rect.height())/1136. , qMin(rect.width(), rect.height())/640.) : 1;
    m_currentCategory = NoteValues::NONE;       // TODO category that has been viewed before closing the app

    m_sqlInterface = new SqlNoteInterface(this);

    m_colors = new QQmlPropertyMap(this);
    m_colors->insert(QLatin1String("separator"), QVariant("#133a0f"));
    m_colors->insert(QLatin1String("currentItem"), QVariant("#66bb6a"));
    m_colors->insert(QLatin1String("categoryIndicator"), QVariant("#aed581"));
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
        m_previousNote = m_currentNote;
        m_currentNote = currentNote;
        emit currentNoteChanged();
    }
}

void NoteEverywhere::setSearchQuery(const QString &searchQuery)
{
    if (m_searchQuery != searchQuery){
        m_searchQuery = searchQuery;
        searchNotes();
    }
}

void NoteEverywhere::populateModel()
{
    m_model = m_sqlInterface->populateModel();
    emit modelChanged();
}

void NoteEverywhere::searchNotes()
{
    m_model = m_sqlInterface->notesFor(m_searchQuery, m_currentCategory);
    emit modelChanged();
}

QString NoteEverywhere::categoryAsText(int category) const
{
    switch (category){
    case NoteValues::WORK: return QString("Work"); break;
    case NoteValues::ENTERTAINMENT: return QString("Entertainment"); break;
    case NoteValues::HOBBY: return QString("Hobby"); break;
    case NoteValues::HOME: return QString("Home"); break;
    case NoteValues::NONE: return QString("None"); break;
    default: return QString();
    }
}

void NoteEverywhere::changeNoteCategory(Note *note, int category)
{
    qDebug() << note;
    if (note->category() == category) {
        return;
    }

    /*
     * If 'm_currentCategory' has "NoteValues::NONE" value 'note' will not be deleted, because no matter what category it is assigned to, it will still be visible in 'NONE' category.
     * 'note' is deleted from the model only if category is different.
     * Deleting notes has consequences, if deleted note was assigned to 'm_currentNote' or 'm_previousNote' those fields should be updated.
     * Both model and database are updated not matter what category is the current one.
     *
     * */
    int id = note->id();

    if (m_currentCategory != NoteValues::NONE) {
        if (m_previousNote == note) {
            m_previousNote = NULL;
        }

        if (m_currentNote == note) {
            m_currentNote = NULL;
        }

        m_model->removeNote(m_model->indexOf(note));
    }
    else {
        m_model->setCategoryAt(m_model->indexOf(note), category);
    }
    m_sqlInterface->updateNoteCategory(id, category);
}
