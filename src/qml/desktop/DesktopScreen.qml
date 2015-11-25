import QtQuick 2.5
import "qrc:/core/src/qml/core"

Item {
    id: root

    CategoryListView {
        id: categoryListView
        y: noteListView.toolbar.height
        width: 150 * NoteEverywhere.ratio
        height: parent.height
    }

    NoteListView {
        id: noteListView
        toolbar.x: -categoryListView.width
        toolbar.width: categoryListView.width + width
        width: 200 * NoteEverywhere.ratio
        height: parent.height
        anchors.left: categoryListView.right
        anchors.leftMargin: 2 * NoteEverywhere.ratio
    }

    NoteEditFrame {
        anchors.left: noteListView.right
        anchors.right: parent.right
        anchors.leftMargin: 3 * NoteEverywhere.ratio
        height: parent.height
    }
}

