import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {

    NoteListViewToolBar {
        id: toolbar
        z: 1

        createNewNoteButton.onClicked: {
            var rowId = NoteEverywhere.sqlInterface.addNote("New Note" + NoteEverywhere.model.size, "", NoteEverywhere.currentCategory)
            NoteEverywhere.model.addNote(rowId, "New Note" + NoteEverywhere.model.size, "", NoteEverywhere.currentCategory)
            listView.positionViewAtEnd()
        }
    }


    ListView {
        id: listView
        anchors.top: toolbar.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        model: NoteEverywhere.model
        delegate: NoteDelegate {}
        boundsBehavior: Flickable.DragOverBounds

        Component.onCompleted: NoteEverywhere.populateModel()
    }
}
