import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: root
    width: parent.width
    height: NoteEverywhere.ratio * 50

    property alias mouseArea: mouseArea
    property int pixelSize: 14

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: dropArea.containsDrag? Qt.CrossCursor : Qt.ArrowCursor
    }

    DropArea {
        id: dropArea
        anchors.fill: parent
        onDropped: NoteEverywhere.changeNoteCategory(drag.source, model.category)
    }

    Rectangle {
        anchors.fill: parent
        color: NoteEverywhere.colors.currentItem
        opacity: mouseArea.containsMouse && !root.ListView.isCurrentItem? 0.3 : 0.0

        Behavior on opacity {
            PropertyAnimation { duration: 50 }
        }
    }

    Label {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10 * NoteEverywhere.ratio
        anchors.rightMargin: 10 * NoteEverywhere.ratio
        width: parent.width
        text: model.name
        elide: Text.ElideRight
        font.pixelSize: root.pixelSize * NoteEverywhere.ratio
    }
}
