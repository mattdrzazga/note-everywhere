import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0
import QtQuick.Dialogs 1.2

Item {
    id: root
    signal previousPage()

    property bool _savedByBackButton: false

    function onDestructionSlot() {
        if (NoteEverywhere.currentNote){
            if (NoteEverywhere.currentNote.content !== contentTextArea.text) {
                NoteEverywhere.model.setContentAt(NoteEverywhere.model.indexOf(NoteEverywhere.currentNote.id), contentTextArea.text)
                NoteEverywhere.sqlInterface.updateNoteContent(NoteEverywhere.currentNote.id, contentTextArea.text)
            }
        }
    }

    Component.onDestruction: if (!_savedByBackButton ) onDestructionSlot()


    Component.onCompleted: {
        textFormatter.text = NoteEverywhere.currentNote? NoteEverywhere.currentNote.content : ""
        textFormatter.textChanged()
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
            onRejected: colorDialogLoader.active = false
        }
    }

    NoteEditFrameToolBar {
        id: noteEditFrameToolbar
        z: 10

        backButton.onClicked: {
            root.previousPage()
            root.onDestructionSlot()
            root._savedByBackButton = true
        }

        boldAction.onTriggered:           textFormatter.bold      = !textFormatter.bold
        italicAction.onTriggered:         textFormatter.italic    = !textFormatter.italic
        underlineAction.onTriggered:      textFormatter.underline = !textFormatter.underline
        strikethroughAction.onTriggered:  textFormatter.strikethrough = !textFormatter.strikethrough

        alignLeftAction.onTriggered:      textFormatter.alignment = Qt.AlignLeft
        alignCenterAction.onTriggered:    textFormatter.alignment = Qt.AlignHCenter
        alignRightAction.onTriggered:     textFormatter.alignment = Qt.AlignRight
        alignJustifyAction.onTriggered:   textFormatter.alignment = Qt.AlignJustify

        unorderedListAction.onTriggered:  textFormatter.setUnorderedListFormat()
        orderedListAction.onTriggered:    textFormatter.setOrderedListFormat()
        increaseIndentAction.onTriggered: textFormatter.increaseIndent()
        decreaseIndentAction.onTriggered: textFormatter.decreaseIndent()
        selectFontColorAction.onTriggered: colorDialogLoader.active = true
    }

    TextArea {
        id: contentTextArea
        width: parent.width
        anchors.top: noteEditFrameToolbar.bottom
        anchors.bottom: parent.bottom
        frameVisible: true
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

        onBoldChanged:  noteEditFrameToolbar.boldAction.checked = bold
        onItalicChanged: noteEditFrameToolbar.italicAction.checked = italic
        onUnderlineChanged: noteEditFrameToolbar.underlineAction.checked = underline
        onStrikethroughChanged: noteEditFrameToolbar.strikethroughAction.checked = strikethrough

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

        /*
            From Qt docs:
            QTextListFormat::ListDisc       -1	a filled circle
            QTextListFormat::ListDecimal	-4	decimal values in ascending order
            QTextListFormat::ListUpperRoman	-8	upper case roman numerals (supports up to 4999 items only)
        */
        onListFormatChanged: {
            noteEditFrameToolbar.orderedListAction.checked = (listFormat <= -4 && listFormat >= -8)? true : false
            noteEditFrameToolbar.unorderedListAction.checked = (listFormat <= -1 && listFormat >= -3)? true : false
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
