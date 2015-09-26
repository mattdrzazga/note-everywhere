import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

Rectangle {

    NoteListViewToolBar {
        id: toolbar
        z: 1

        createNewNoteButton.onClicked: {
            var rowId = NoteEverywhere.sqlInterface.addNote("New Note", "", NoteEverywhere.currentCategory)
            NoteEverywhere.model.addNote(rowId, "New Note", "", NoteEverywhere.currentCategory)
            listView.positionViewAtEnd()
            listView.currentIndex = NoteEverywhere.model.size - 1
        }
    }

    MessageDialog {
        id: deleteNoteDialog
        title: "Delete note"
        text: "Do you really want to delete this note?";
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            var id = NoteEverywhere.model.getNote(listView.currentIndex).id
            NoteEverywhere.sqlInterface.deleteNote(id)
            NoteEverywhere.model.removeNote(listView.currentIndex)
        }
    }

    ListView {
        id: listView
        anchors.top: toolbar.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        model: NoteEverywhere.model
        delegate: NoteDelegate {
            mouseArea.onClicked: listView.currentIndex = model.index
        }
        onCurrentIndexChanged: console.log(currentIndex)
        boundsBehavior: Flickable.DragOverBounds
        focus: true
        highlightMoveDuration: 100

        Keys.onPressed: {
            if (event.key === Qt.Key_End){
                listView.positionViewAtEnd()
                currentIndex = NoteEverywhere.model.size - 1
            }
            else if (event.key === Qt.Key_Home){
                listView.positionViewAtBeginning()
                currentIndex = 0
            }
        }

        Keys.onDeletePressed: deleteNoteDialog.open()

        Component.onCompleted: NoteEverywhere.populateModel()
    }
}
