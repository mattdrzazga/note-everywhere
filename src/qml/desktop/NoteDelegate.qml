import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Item {
    id: root
    width: parent.width
    height: 50 * NoteEverywhere.ratio

    property alias mouseArea: mouseArea

    Rectangle {
        anchors.fill: parent
        color: root.ListView.isCurrentItem? "#45a4af" : "white"
        opacity: 0.5
        Behavior on color { ColorAnimation { duration: 50 } }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10 * NoteEverywhere.ratio
        anchors.rightMargin: 10 * NoteEverywhere.ratio

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter

            Label {
                Layout.preferredWidth: root.width - 20 * NoteEverywhere.ratio - toolButton.width
                text: model.name
                font.pixelSize: 13 * NoteEverywhere.ratio
            }

            Label {
                Layout.preferredWidth: root.width - 20 * NoteEverywhere.ratio - toolButton.width
                text: model.lastModificationDateTime.toLocaleString(Qt.locale(), Locale.ShortFormat)
                font.pixelSize: 12 * NoteEverywhere.ratio
            }
        }

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

    Rectangle {
        height: 1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10 * NoteEverywhere.ratio
        anchors.rightMargin: 10 * NoteEverywhere.ratio
        color: "#133a0f"
    }
}
