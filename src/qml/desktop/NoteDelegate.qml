import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Item {
    id: root
    width: parent.width
    height: 50 * NoteEverywhere.ratio

    property alias mouseArea: mouseArea

    //  Highlight component
    Rectangle {
        anchors.fill: parent
        color: root.ListView.isCurrentItem? "#45a4af" : "white"
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
                Layout.preferredWidth: root.width - 20 * NoteEverywhere.ratio - toolButton.width
                text: model.name
                font.pixelSize: 13 * NoteEverywhere.ratio
            }

            //  Note last modification date and time
            Label {
                Layout.preferredWidth: root.width - 20 * NoteEverywhere.ratio - toolButton.width
                text: model.lastModificationDateTime.toLocaleString(Qt.locale(), Locale.ShortFormat)
                font.pixelSize: 12 * NoteEverywhere.ratio
            }
        }
            // Note category button
        ToolButton {
            id: toolButton

            function onTriggeredSlot(category) {
                if (model.category !== category){
                    NoteEverywhere.model.setCategoryAt(model.index, category)
                    NoteEverywhere.sqlInterface.updateNoteCategory(model.id, category)
                }
            }

            iconSource: PathResolver.categoryIcon(model.category)
            Layout.alignment: Qt.AlignRight
            menu: Menu {
                MenuItem {
                    text: "Work"
                    iconSource: PathResolver.categoryIcon(Ne.WORK)
                    onTriggered: toolButton.onTriggeredSlot(Ne.WORK)
                }

                MenuItem {
                    text: "Entertainment"
                    iconSource: PathResolver.categoryIcon(Ne.ENTERTAINMENT)
                    onTriggered: toolButton.onTriggeredSlot(Ne.ENTERTAINMENT)
                }

                MenuItem {
                    text: "Hobby"
                    iconSource: PathResolver.categoryIcon(Ne.HOBBY)
                    onTriggered: toolButton.onTriggeredSlot(Ne.HOBBY)
                }

                MenuItem {
                    text: "Home"
                    iconSource: PathResolver.categoryIcon(Ne.HOME)
                    onTriggered: toolButton.onTriggeredSlot(Ne.HOME)
                }

                MenuItem {
                    text: "None"
                    iconSource: PathResolver.categoryIcon(Ne.NONE)
                    onTriggered: toolButton.onTriggeredSlot(Ne.NONE)
                }
            }
        }
    }

    // Horizontal separator between next note
    Rectangle {
        width: parent.width
        height: 1
        anchors.bottom: parent.bottom
        color: "#133a0f"
        opacity: 0.3
    }
}
