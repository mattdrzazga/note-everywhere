import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

import NoteEverywhere 1.0

Rectangle {

    ToolBar {
        id: toolBar

        RowLayout {
            anchors.fill: parent

            Item { Layout.fillWidth: true }

            ToolButton {
                menu: Menu {
                    MenuItem {
                        text: "Quit"
                        onTriggered: Qt.quit()
                    }
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.top: toolBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        delegate: CategoryDelegate{
            color: ListView.isCurrentItem? NoteEverywhere.colors.currentItem : "white"

            mouseArea.onClicked: {
                listView.currentIndex = index
            }
        }

        model: ListModel {
            ListElement { name: "All Notes"; category: Ne.NONE }
            ListElement { name: "Work"; category: Ne.WORK }
            ListElement { name: "Entertainment"; category: Ne.ENTERTAINMENT }
            ListElement { name: "Hobby"; category: Ne.HOBBY }
            ListElement { name: "Home"; category: Ne.HOME }
        }

        onCurrentIndexChanged: {
            var category = listView.model.get(currentIndex).category
            if (NoteEverywhere.currentCategory !== category) {
                NoteEverywhere.currentCategory = category
                NoteEverywhere.searchNotes()
            }
        }
    }
}
