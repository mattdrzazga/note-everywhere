#include "textformatter.h"
#include <QDebug>
#include <QQuickTextDocument>
#include <QTextCursor>
#include <QTextListFormat>
#include <QTextList>

TextFormatter::TextFormatter(QObject *parent):
    QObject(parent),
    m_target(0),
    m_document(0),
    m_cursorPosition(-1),
    m_selectionStart(0),
    m_selectionEnd(0)
{

}

bool TextFormatter::bold() const
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return false;
    return cursor.charFormat().fontWeight() == QFont::Bold;
}

bool TextFormatter::italic() const
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return false;
    return cursor.charFormat().fontItalic();
}

bool TextFormatter::underline() const
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return false;
    return cursor.charFormat().fontUnderline();
}

Qt::Alignment TextFormatter::alignment() const
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return Qt::AlignLeft;
    //TODO find a better way to return Qt::AlignRight
    // Currently, comparing ...alignment() with Qt::AlignRight does not return true, because alignment does not have Qt::AlignRight value,
    // instead it has bitwise OR value (0x2|0x10)

    else if (cursor.blockFormat().alignment() == (0x2|0x10)){
        return Qt::AlignRight;
    }
    else{
        return cursor.blockFormat().alignment();
    }
}

QColor TextFormatter::textColor() const
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return Qt::black;

    QTextCharFormat format = cursor.charFormat();
    return format.foreground().color();
}

int TextFormatter::fontSize() const
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return 0;

    return cursor.charFormat().font().pointSize();
}

QString TextFormatter::fontFamily() const
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return QString();

    QTextCharFormat format = cursor.charFormat();
    return format.font().family();
}

QTextListFormat::Style TextFormatter::listFormat() const
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return QTextListFormat::ListStyleUndefined;

    if (cursor.currentList())
        return cursor.currentList()->format().style();

    else
        return QTextListFormat::ListStyleUndefined;

}

void TextFormatter::reset()
{
    emit fontFamilyChanged();
    emit alignmentChanged();
    emit boldChanged();
    emit italicChanged();
    emit underlineChanged();
    emit fontSizeChanged();
    emit textColorChanged();
    emit listFormatChanged();
}

void TextFormatter::setText(const QString &text)
{
    if (m_text != text){
        m_text = text;
        emit textChanged();
    }
}

void TextFormatter::setBold(bool bold)
{
    QTextCharFormat format;
    format.setFontWeight( bold ? QFont::Bold : QFont::Normal );
    applyFormat(format);
    emit boldChanged();
}

void TextFormatter::setItalic(bool italic)
{
    QTextCharFormat format;
    format.setFontItalic(italic);
    applyFormat(format);
    emit italicChanged();
}

void TextFormatter::setUnderline(bool underline)
{
    QTextCharFormat format;
    format.setFontUnderline(underline);
    applyFormat(format);
    emit underlineChanged();
}

void TextFormatter::setFontSize(int fontSize)
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return;

    QTextCharFormat format;
    format.setFontPointSize(fontSize);
    applyFormat(format);
    emit fontSizeChanged();
}

void TextFormatter::setFontFamily(const QString &fontFamily)
{
    QTextCursor cursor = textCursor();
    if (cursor.isNull())
        return;

    QTextCharFormat format;
    format.setFontFamily(fontFamily);
    applyFormat(format);

    emit fontFamilyChanged();
}

void TextFormatter::setUnorderedListFormat()
{
    int listFormatValue = listFormat();
    --listFormatValue;

    if (listFormatValue == QTextListFormat::ListDecimal)
        listFormatValue = QTextListFormat::ListStyleUndefined;

    else if (listFormatValue < QTextListFormat::ListSquare)
        listFormatValue = QTextListFormat::ListDisc;

    setTextStyle(listFormatValue);
    listFormatChanged();
}

void TextFormatter::setOrderedListFormat()
{
    int listFormatValue = listFormat();
    --listFormatValue;

    if (listFormatValue >= QTextListFormat::ListSquare)
        listFormatValue = QTextListFormat::ListDecimal;
    else if (listFormatValue < QTextListFormat::ListUpperRoman)
        listFormatValue = QTextListFormat::ListStyleUndefined;

    setTextStyle(listFormatValue);
    listFormatChanged();
}

void TextFormatter::increaseIndent()
{
    QTextCursor cursor = textCursor();
    QTextBlockFormat blockFormat = cursor.blockFormat();
    blockFormat.setIndent(blockFormat.indent() + 1);
    cursor.mergeBlockFormat(blockFormat);
}

void TextFormatter::decreaseIndent()
{
    QTextCursor cursor = textCursor();
    QTextBlockFormat blockFormat = cursor.blockFormat();
    // This forbids text to be 'indented' outside left border.
    blockFormat.setIndent(blockFormat.indent() == 0 ? 0 : blockFormat.indent() - 1);
    cursor.mergeBlockFormat(blockFormat);
}

void TextFormatter::setTextStyle(int styleIndex)
{
    QTextCursor cursor = textCursor();

    if (styleIndex != 0) {
        QTextListFormat::Style style = QTextListFormat::ListDisc;

        style = determineStyle(styleIndex);
        cursor.beginEditBlock();

        QTextBlockFormat blockFormat = cursor.blockFormat();
        QTextListFormat listFormat;

        if (cursor.currentList()) {
            listFormat = cursor.currentList()->format();
        }
        else {
            listFormat.setIndent(blockFormat.indent() + 1);
            blockFormat.setIndent(0);
            cursor.setBlockFormat(blockFormat);
        }

        listFormat.setStyle(style);
        cursor.createList(listFormat);

        cursor.endEditBlock();
    }
    else {
        QTextBlockFormat bfmt;
        bfmt.setObjectIndex(0);
        cursor.mergeBlockFormat(bfmt);
    }
}

QTextListFormat::Style TextFormatter::determineStyle(int styleIndex) const
{
    QTextListFormat::Style style = QTextListFormat::ListDisc;

    switch (styleIndex) {
    case -1:
        style = QTextListFormat::ListDisc;
        break;
    case -2:
        style = QTextListFormat::ListCircle;
        break;
    case -3:
        style = QTextListFormat::ListSquare;
        break;
    case -4:
        style = QTextListFormat::ListDecimal;
        break;
    case -5:
        style = QTextListFormat::ListLowerAlpha;
        break;
    case -6:
        style = QTextListFormat::ListUpperAlpha;
        break;
    case -7:
        style = QTextListFormat::ListLowerRoman;
        break;
    case -8:
        style = QTextListFormat::ListUpperRoman;
        break;
    }

    return style;
}

void TextFormatter::setAlignment(Qt::Alignment alignment)
{
    QTextBlockFormat format;
    format.setAlignment(alignment);
    QTextCursor cursor(m_document);
    cursor.setPosition(m_selectionStart, QTextCursor::MoveAnchor);
    cursor.setPosition(m_selectionEnd, QTextCursor::KeepAnchor);
    cursor.mergeBlockFormat(format);

    emit alignmentChanged();
}

void TextFormatter::setTextColor(const QColor &color)
{
    QTextCursor cursor = textCursor();
    QTextCharFormat format;
    format.setForeground(QBrush(color));
    applyFormat(format);

    emit textColorChanged();
}
void TextFormatter::setTarget(QQuickItem *target)
{
    if (!target)
        return;

    m_document = 0;
    m_target = target;

    QVariant document = m_target->property("textDocument");
    if (document.canConvert<QQuickTextDocument*>()) {
        QQuickTextDocument *quickTextDocument = document.value<QQuickTextDocument*>();
        m_document = quickTextDocument->textDocument();
    }

    emit targetChanged();
}


void TextFormatter::applyFormat(const QTextCharFormat &format)
{
    QTextCursor cursor = textCursor();
    if (!cursor.hasSelection())
        cursor.select(QTextCursor::WordUnderCursor);
    cursor.mergeCharFormat(format);
}

QTextCursor TextFormatter::textCursor() const
{
    QTextCursor cursor(m_document);
    if (m_selectionStart != m_selectionEnd){
        cursor.setPosition(m_selectionStart);
        cursor.setPosition(m_selectionEnd, QTextCursor::KeepAnchor);
    }
    else{
        cursor.setPosition(m_cursorPosition);
    }

    return cursor;
}

void TextFormatter::setSelectionStart(int selectionStart)
{
    if (m_selectionStart != selectionStart)
        m_selectionStart = selectionStart;
}

void TextFormatter::setSelectionEnd(int selectionEnd)
{
    if (m_selectionEnd != selectionEnd)
        m_selectionEnd = selectionEnd;
}

void TextFormatter::setCursorPosition(int position)
{
    if (position == m_cursorPosition)
        return;

    m_cursorPosition = position;

    reset();
}
