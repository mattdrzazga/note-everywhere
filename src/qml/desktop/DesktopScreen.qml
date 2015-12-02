import QtQuick 2.5
import "qrc:/core/src/qml/core"

Item {
    id: root


    NoteListViewToolBar {
        id: noteListViewToolBar
        z: 1
        createNewNoteButton.onClicked: noteListView.createNewNote()
        width: categoryListView.width + noteListView.width
    }

    CategoryListView {
        id: categoryListView
        anchors.top: noteListViewToolBar.bottom
        anchors.bottom: parent.bottom
        width: 150 * NoteEverywhere.ratio
        height: parent.height
        KeyNavigation.tab: noteListView
    }

    NoteListView {
        id: noteListView
        width: 200 * NoteEverywhere.ratio
        anchors.top: noteListViewToolBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: categoryListView.right
        anchors.leftMargin: 2 * NoteEverywhere.ratio
        toolBar: noteListViewToolBar
        KeyNavigation.backtab: categoryListView
    }

    NoteEditFrame {
        anchors.left: noteListView.right
        anchors.right: parent.right
        anchors.leftMargin: 2 * NoteEverywhere.ratio
        height: parent.height
    }
}

