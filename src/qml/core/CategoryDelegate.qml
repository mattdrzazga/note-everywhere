import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: root
    width: parent.width
    height: 50 * NoteEverywhere.ratio

    property alias mouseArea: mouseArea

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
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
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        width: parent.width
        text: model.name
        elide: Text.ElideRight
        font.pointSize: 12
    }
}
