import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Item {

    NoteEditFrameToolbar {
        id: noteEditFrameToolbar
        boldButton.onClicked:           textFormatter.bold      = !textFormatter.bold
        italicButton.onClicked:         textFormatter.italic    = !textFormatter.italic
        underlineButton.onClicked:      textFormatter.underline = !textFormatter.underline
        strikethroughButton.onClicked:  textFormatter.strikethrough = !textFormatter.strikethrough

        alignLeftButton.onClicked:      textFormatter.alignment = Qt.AlignLeft
        alignCenterButton.onClicked:    textFormatter.alignment = Qt.AlignHCenter
        alignRightButton.onClicked:     textFormatter.alignment = Qt.AlignRight
        alignJustifyButton.onClicked:   textFormatter.alignment = Qt.AlignJustify

        unorderedListButton.onClicked:  textFormatter.setUnorderedListFormat()
        orderedListButton.onClicked:    textFormatter.setOrderedListFormat()
        increaseIndentButton.onClicked: textFormatter.increaseIndent()
        decreaseIndentButton.onClicked: textFormatter.decreaseIndent()
    }

    TextArea {
        id: contentTextArea
        width: parent.width
        anchors.top: noteEditFrameToolbar.bottom
        anchors.bottom: parent.bottom
        frameVisible: false
        textFormat: TextEdit.RichText
        text: textFormatter.text
        enabled: NoteEverywhere.currentNote? true : false
    }


    TextFormatter{
        id: textFormatter
        target: contentTextArea
        text: NoteEverywhere.currentNote? NoteEverywhere.currentNote.content : " "
        cursorPosition: contentTextArea.cursorPosition
        selectionStart: contentTextArea.selectionStart
        selectionEnd: contentTextArea.selectionEnd
        onBoldChanged: noteEditFrameToolbar.boldButton.checked = bold
        onItalicChanged: noteEditFrameToolbar.italicButton.checked = italic
        onUnderlineChanged: noteEditFrameToolbar.underlineButton.checked = underline
        onStrikethroughChanged: noteEditFrameToolbar.strikethroughButton.checked = strikethrough

        onAlignmentChanged:{
            var currentAlignment = alignment

            if (currentAlignment == Qt.AlignLeft){
                noteEditFrameToolbar.alignLeftAction.checked = true
            }
            else if (currentAlignment == Qt.AlignHCenter){
                noteEditFrameToolbar.centerHorizontallyAction.checked = true
            }
            else if (currentAlignment == Qt.AlignRight){
                noteEditFrameToolbar.alignRightAction.checked = true
            }
            else if (currentAlignment == Qt.AlignJustify){
                noteEditFrameToolbar.alignJustifyAction.checked = true
            }
        }
    }
}
