import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import NoteEverywhere 1.0
import "qrc:/core/src/qml/core"

Item {
    id: root
    width: parent.width
    height: NoteEverywhere.ratio * NoteEverywhere.isMobile? 120 : 50

    property alias mouseArea: mouseArea
    property Item dragRootItem: undefined

    Rectangle {
        id: dragItem
        width: root.width
        height: root.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.ListView.isCurrentItem? NoteEverywhere.colors.currentItem : "white"
        scale: mouseArea.held? 0.8 : 1

        Drag.active: mouseArea.drag.active
        Drag.source: NoteEverywhere.model.getNote(index)
        Drag.hotSpot.x: width/2
        Drag.hotSpot.y: height/2

        Behavior on scale { PropertyAnimation { duration: 75 } }

        // This rectangle is indicating that the mouse is inside by changing color.
        Rectangle {
            anchors.fill: parent
            color: NoteEverywhere.colors.currentItem
            opacity: mouseArea.containsMouse && !root.ListView.isCurrentItem? 0.3 : 0.0

            Behavior on opacity { PropertyAnimation { duration: 50 } }
        }

        //  MouseArea that covers entire delegate. It is used to change currentIndex and can handle contextMenu
        MouseArea {
            id: mouseArea

            property bool held: false

            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            hoverEnabled: true
            drag.target: held? dragItem : undefined

            onPressAndHold: held = true
            onReleased: { dragItem.Drag.drop(); held = false }
        }

        ColumnLayout {
            id: columnLayout
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
                font.pixelSize: NoteEverywhere.isMobile? 26 : 12
                elide: Text.ElideRight
            }

            //  Note last modification date and time
            Label {
                Layout.preferredWidth: implicitWidth
                text: model.lastModificationDateTime.toLocaleString(Qt.locale(), Locale.ShortFormat)
                font.pixelSize: NoteEverywhere.isMobile? 22 : 11
            }
        }

        CategoryIndicator {
            anchors.right: parent.right
            anchors.rightMargin: 10 * NoteEverywhere.ratio
            anchors.bottom: columnLayout.bottom
        }


        states: State {
            when: mouseArea.held

            ParentChange {
                target: dragItem
                parent: root.dragRootItem
            }

            AnchorChanges {
                target: dragItem
                anchors.verticalCenter: undefined
                anchors.horizontalCenter: undefined
            }
        }
    }
}
