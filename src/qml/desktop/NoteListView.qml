import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

Rectangle {
    property NoteListViewToolBar toolBar

    function createNewNote() {
        var rowId = NoteEverywhere.sqlInterface.addNote("New Note", "", NoteEverywhere.currentCategory)
        NoteEverywhere.model.addNote(rowId, "New Note", "", NoteEverywhere.currentCategory)
        listView.positionViewAtEnd()
        listView.currentIndex = NoteEverywhere.model.size - 1
    }

    MessageDialog {
        id: deleteNoteDialog
        title: "Delete note"
        text: "Do you really want to delete this note?";
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            var id = NoteEverywhere.currentNote.id
            NoteEverywhere.sqlInterface.deleteNote(id)
            NoteEverywhere.model.removeNote(listView.currentIndex)
        }
    }

    Dialog {
        id: renameNoteDialog
        title: "Rename note"
        standardButtons: StandardButton.Ok | StandardButton.Cancel
        onVisibleChanged: {
            if (visible) {
                editNoteNameField.text = NoteEverywhere.currentNote.name
                editNoteNameField.forceActiveFocus()
                editNoteNameField.selectAll()
            }
        }

        onAccepted: {
            var currentNoteId = NoteEverywhere.currentNote.id
            NoteEverywhere.sqlInterface.updateNoteName(currentNoteId, editNoteNameField.text)
            NoteEverywhere.model.setNameAt(listView.currentIndex, editNoteNameField.text)
        }

        TextField { id: editNoteNameField }
    }

    Menu {
        id: contextMenu
        MenuItem {
            action: toolBar.noteListActions.renameAction
            onTriggered: if (NoteEverywhere.currentNote) renameNoteDialog.open()
        }
        MenuItem {
            action: toolBar.noteListActions.deleteAction
            onTriggered: if (NoteEverywhere.currentNote) deleteNoteDialog.open()
        }
    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        model: NoteEverywhere.model
        boundsBehavior: Flickable.StopAtBounds
        focus: true
        highlightMoveDuration: 10
        highlightMoveVelocity: 1000
        clip: true

        delegate: NoteDelegate {
            mouseArea.onClicked: {
                listView.currentIndex = model.index
                if (mouse.button === Qt.RightButton) {
                    contextMenu.popup()
                }
            }
        }

        highlight: Rectangle {
            color: NoteEverywhere.colors.currentItem
        }

        onCurrentIndexChanged: {
            NoteEverywhere.currentNote = NoteEverywhere.model.getNote(currentIndex)
        }

        onModelChanged: {   // TypeError 'Cannot read property 'size' of null' can be ignored, it can also be prevented by checking if model exists. For future consideration.
            if (NoteEverywhere.model && NoteEverywhere.model.size === 0) {
                NoteEverywhere.currentNote = null
            }
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_End){
                listView.positionViewAtEnd()
                currentIndex = NoteEverywhere.model.size - 1
            }
            else if (event.key === Qt.Key_Home){
                listView.positionViewAtBeginning()
                currentIndex = 0
            }
            else if (event.key === Qt.Key_Find){ //TODO Czemu to nie działa?
                console.log("find clicked")
                toolbar.searchTextField.forceActiveFocus()
            }
        }

        Component.onCompleted: NoteEverywhere.populateModel()
    }
}
