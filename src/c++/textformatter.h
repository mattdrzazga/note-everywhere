#ifndef TEXTFORMATTER_H
#define TEXTFORMATTER_H

#include <QObject>
#include <QTextCharFormat>
#include <QQuickItem>

class TextFormatter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QObject * parent READ parent WRITE setParent NOTIFY parentChanged)
    Q_PROPERTY(QQuickItem * target READ target WRITE setTarget NOTIFY targetChanged)

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(int cursorPosition READ cursorPosition WRITE setCursorPosition NOTIFY cursorPositionChanged)
    Q_PROPERTY(int selectionStart READ selectionStart WRITE setSelectionStart NOTIFY selectionStartChanged)
    Q_PROPERTY(int selectionEnd READ selectionEnd WRITE setSelectionEnd NOTIFY selectionEndChanged)

    Q_PROPERTY(bool bold READ bold WRITE setBold NOTIFY boldChanged)
    Q_PROPERTY(bool italic READ italic WRITE setItalic NOTIFY italicChanged)
    Q_PROPERTY(bool underline READ underline WRITE setUnderline NOTIFY underlineChanged)
    Q_PROPERTY(bool strikethrough READ strikethrough WRITE setStrikethrough NOTIFY strikethroughChanged)
    Q_PROPERTY(Qt::Alignment alignment READ alignment WRITE setAlignment NOTIFY alignmentChanged)
    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)
    Q_PROPERTY(int fontSize READ fontSize WRITE setFontSize NOTIFY fontSizeChanged)
    Q_PROPERTY(QString fontFamily READ fontFamily WRITE setFontFamily NOTIFY fontFamilyChanged)
    Q_PROPERTY(int listFormat READ listFormat NOTIFY listFormatChanged)

public:
    explicit TextFormatter(QObject *parent = 0);

    inline QString text() const {return m_text;}
    inline int cursorPosition() const {return m_cursorPosition;}
    inline int selectionStart() const {return m_selectionStart;}
    inline int selectionEnd() const {return m_selectionEnd;}
    inline QQuickItem* target() const {return m_target;}

    bool bold() const;
    bool italic() const;
    bool underline() const;
    bool strikethrough() const;
    Qt::Alignment alignment() const;
    QColor textColor() const;
    int fontSize() const;
    QString fontFamily() const;
    QTextListFormat::Style listFormat() const;
    void reset();


signals:
    void textChanged();
    void cursorPositionChanged(int position);
    void selectionStartChanged(int position);
    void selectionEndChanged(int position);
    void targetChanged();
    void parentChanged(QObject *parent);

    void boldChanged();
    void italicChanged();
    void underlineChanged();
    void strikethroughChanged();
    void alignmentChanged();
    void textColorChanged();
    void fontFamilyChanged();
    void fontSizeChanged();
    void listFormatChanged();


public slots:
    void setText(const QString &text);
    void setCursorPosition(int cursorPosition);
    void setSelectionStart(int selectionStart);
    void setSelectionEnd(int selectionEnd);
    void setTarget(QQuickItem *target);

    void setBold(bool bold);
    void setItalic(bool italic);
    void setUnderline(bool underline);
    void setStrikethrough(bool strikethrough);
    void setAlignment(Qt::Alignment alignment);
    void setTextColor(const QColor &color);
    void setFontSize(int fontSize);
    void setFontFamily(const QString &fontFamily);
    void setUnorderedListFormat();
    void setOrderedListFormat();
    void increaseIndent();
    void decreaseIndent();

private:
    QQuickItem *m_target;
    QTextDocument *m_document;

    QString m_text;
    int m_cursorPosition;
    int m_selectionStart;
    int m_selectionEnd;

    void applyFormat(const QTextCharFormat &format);
    QTextCursor textCursor() const;
    void setTextStyle(int styleIndex);
    QTextListFormat::Style determineStyle(int styleIndex) const;
};

#endif // TEXTFORMATTER_H
