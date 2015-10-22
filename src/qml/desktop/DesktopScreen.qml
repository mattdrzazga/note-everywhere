import QtQuick 2.5

Item {
    id: root


    NoteListView {
        id: noteListView
        width: parent.width * 0.3
        height: parent.height
    }

    NoteEditFrame {
        anchors.left: noteListView.right
        anchors.right: parent.right
        anchors.leftMargin: 3 * NoteEverywhere.ratio
        height: parent.height
    }
}

