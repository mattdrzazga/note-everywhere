import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Item {

    NoteEditFrameToolbar {
        id: noteEditFrameToolbar
        boldButton.onClicked:           textFormatter.bold      = !textFormatter.bold
        italicButton.onClicked:         textFormatter.italic    = !textFormatter.italic
        underlineButton.onClicked:      textFormatter.underline = !textFormatter.underline
    }

    TextArea {
        id: contentTextArea
        width: parent.width
        anchors.top: noteEditFrameToolbar.bottom
        anchors.bottom: parent.bottom
        frameVisible: false
        textFormat: TextEdit.RichText
        text: textFormatter.text
    }


    TextFormatter{
        id: textFormatter
        target: contentTextArea
        cursorPosition: contentTextArea.cursorPosition
        selectionStart: contentTextArea.selectionStart
        selectionEnd: contentTextArea.selectionEnd
        onBoldChanged: noteEditFrameToolbar.boldButton.checked = bold
        onItalicChanged: noteEditFrameToolbar.italicButton.checked = italic
        onUnderlineChanged: noteEditFrameToolbar.underlineButton.checked = underline
        text: NoteEverywhere.currentNote.content
    }

}
