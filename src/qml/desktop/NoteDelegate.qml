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

    //  Highlight component
    Rectangle {
        anchors.fill: parent
        color: root.ListView.isCurrentItem? NoteEverywhere.colors.currentItem : "white"
        opacity: 0.5
        Behavior on color { ColorAnimation { duration: 50 } }
    }

    //  MouseArea that covers entire delegate. It is used to change currentIndex and can handle contextMenu
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10 * NoteEverywhere.ratio
        anchors.rightMargin: 10 * NoteEverywhere.ratio

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter

            //  Note Name
            Label {
                id: noteLabel
                Layout.preferredWidth: root.width - 20 * NoteEverywhere.ratio
                text: model.name
                font.pixelSize: 13 * NoteEverywhere.ratio
            }

            //  Note last modification date and time
            Label {
                Layout.preferredWidth: root.width - 20 * NoteEverywhere.ratio
                text: model.lastModificationDateTime.toLocaleString(Qt.locale(), Locale.ShortFormat)
                font.pixelSize: 12 * NoteEverywhere.ratio
            }
        }
    }

    // Horizontal separator between next note
    Rectangle {
        width: parent.width
        height: 1
        anchors.bottom: parent.bottom
        color: NoteEverywhere.colors.separator
        opacity: 0.3
    }
}
