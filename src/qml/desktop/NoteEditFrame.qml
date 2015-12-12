import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0
import QtQuick.Dialogs 1.2

Item {

    Component.onDestruction: {
        if (NoteEverywhere.currentNote){
            if (NoteEverywhere.currentNote.content !== contentTextArea.text){
                NoteEverywhere.sqlInterface.updateNoteContent(NoteEverywhere.currentNote.id, contentTextArea.text)
            }
        }
    }


    Connections {
        target: NoteEverywhere
        onCurrentNoteChanged: {
            saveCurrentNote(NoteEverywhere.previousNote)
            textFormatter.text = NoteEverywhere.currentNote? NoteEverywhere.currentNote.content : ""
            textFormatter.textChanged() //This is it.
        }
    }

    Loader {
        id: colorDialogLoader
        active: false
        sourceComponent: ColorDialog {
            title: "Select font color"
            modality: Qt.WindowModal
            visible: colorDialogLoader.active
            onAccepted: {
                textFormatter.textColor = color
                colorDialogLoader.active = false
            }
        }
    }

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
        selectFontColorButton.onClicked: colorDialogLoader.active = true
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
        onTextChanged: syncTimer.restart()
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
        onStrikethroughChanged: noteEditFrameToolbar.strikethroughButton.checked = strikethrough
        onTextColorChanged: noteEditFrameToolbar.fontColorIndicatorRectangle.color = textColor

        onAlignmentChanged: {
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

    Timer {
        id: syncTimer
        interval: 5000
        onTriggered: saveCurrentNote(NoteEverywhere.currentNote)
    }

    function saveCurrentNote(note) {
        if (!note) return
        if (note.content !== contentTextArea.text){
            note.content = contentTextArea.text
            //textFormatter.text = contentTextArea.text //This would be good if we didn't change textFormatter.text just after this function, in this case, it's resource waste.
            //Instead I only decided to emit TextFormatter.textChanged signal, to reload text in contentTextArea.
            NoteEverywhere.sqlInterface.updateNoteContent(note.id, contentTextArea.text)
        }
    }
}
