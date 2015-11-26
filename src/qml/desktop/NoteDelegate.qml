import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import NoteEverywhere 1.0
import "qrc:/core/src/qml/core"

Item {
    id: root
    width: parent.width
    height: 50 * NoteEverywhere.ratio

    property alias mouseArea: mouseArea

    Rectangle {
        anchors.fill: parent
        color: "#6dde3c"
        opacity: mouseArea.containsMouse && !root.ListView.isCurrentItem? 0.3 : 0.0

        Behavior on opacity {
            PropertyAnimation { duration: 50 }
        }
    }

    //  MouseArea that covers entire delegate. It is used to change currentIndex and can handle contextMenu
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true
    }

    ColumnLayout {
        Layout.alignment: Qt.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10 * NoteEverywhere.ratio
        anchors.rightMargin: 10 * NoteEverywhere.ratio

        //  Note Name
        Label {
            id: noteLabel
            Layout.preferredWidth: root.width - 20 * NoteEverywhere.ratio
            text: model.name
            font.pixelSize: 13 * NoteEverywhere.ratio
            elide: Text.ElideRight
        }

        //  Note last modification date and time
        Label {
            Layout.preferredWidth: root.width - 20 * NoteEverywhere.ratio
            text: model.lastModificationDateTime.toLocaleString(Qt.locale(), Locale.ShortFormat)
            font.pixelSize: 12 * NoteEverywhere.ratio
        }
    }
}
