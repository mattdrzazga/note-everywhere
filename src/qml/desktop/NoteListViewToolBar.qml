import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import NoteEverywhere 1.0

ToolBar {
    id: toolBar
    property alias createNewNoteButton: createNewNoteButton

    RowLayout {
        anchors.fill: parent
        ToolButton {
            id: createNewNoteButton
            iconName: "document-new"
            iconSource: PathResolver.iconPath("document-new");
            tooltip: "Create new note"
        }
        ToolButton {
            iconName: "view-refresh"
            iconSource: PathResolver.iconPath("view-refresh");
            tooltip: "Refresh"
            onClicked: console.log(NoteEverywhere.model.size)
        }
        ToolButton {
            tooltip: "Select category"
            iconSource: PathResolver.categoryIcon(NoteEverywhere.currentCategory)
            menu: Menu {
                MenuItem {
                    text: "Work"
                    iconSource: PathResolver.categoryIcon(Ne.WORK)
                    onTriggered: NoteEverywhere.currentCategory = Ne.WORK
                }

                MenuItem {
                    text: "Entertainment"
                    iconSource: PathResolver.categoryIcon(Ne.ENTERTAINMENT)
                    onTriggered: NoteEverywhere.currentCategory = Ne.ENTERTAINMENT
                }

                MenuItem {
                    text: "Hobby"
                    iconSource: PathResolver.categoryIcon(Ne.HOBBY)
                    onTriggered: NoteEverywhere.currentCategory = Ne.HOBBY
                }

                MenuItem {
                    text: "Home"
                    iconSource: PathResolver.categoryIcon(Ne.HOME)
                    onTriggered: NoteEverywhere.currentCategory = Ne.HOME
                }

                MenuItem {
                    text: "None"
                    iconSource: PathResolver.categoryIcon(Ne.NONE)
                    onTriggered: NoteEverywhere.currentCategory = Ne.NONE
                }
            }
        }

        Item { Layout.fillWidth: true }

        SearchThemedTextField { Layout.alignment: Qt.AlignRight; Layout.fillWidth: true; Layout.maximumWidth: 400 * NoteEverywhere.ratio }
    }
}
