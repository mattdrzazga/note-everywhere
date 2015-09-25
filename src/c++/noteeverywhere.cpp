#include "noteeverywhere.h"
#include <QGuiApplication>
#include <QScreen>
#include <QDebug>

NoteEverywhere::NoteEverywhere(QObject *parent) : QObject(parent), m_model(0)
{
    m_isMobile = false;
#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(Q_OS_BLACKBERRY)
    m_isMobile = true;
#endif

    QRect rect = qApp->primaryScreen()->geometry();
    m_ratio = m_isMobile ? qMin(qMax(rect.width(), rect.height())/1136. , qMin(rect.width(), rect.height())/640.) : 1;
    m_category = NoteValues::NONE;
}

void NoteEverywhere::setCategory(const NoteValues::Category &category)
{
    if (m_category != category){
        m_category = category;
        emit categoryChanged(m_category);
    }
}
