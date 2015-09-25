import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import NoteEverywhere 1.0

ToolBar {
    id: toolBar

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
        }
        ToolButton {
            tooltip: "Select category"
            iconSource: PathResolver.categoryIcon(NoteEverywhere.category)
            menu: Menu {
                MenuItem {
                    text: "Work"
                    iconSource: PathResolver.categoryIcon(Ne.WORK)
                    onTriggered: NoteEverywhere.category = Ne.WORK
                }

                MenuItem {
                    text: "Entertainment"
                    iconSource: PathResolver.categoryIcon(Ne.ENTERTAINMENT)
                    onTriggered: NoteEverywhere.category = Ne.ENTERTAINMENT
                }

                MenuItem {
                    text: "Hobby"
                    iconSource: PathResolver.categoryIcon(Ne.HOBBY)
                    onTriggered: NoteEverywhere.category = Ne.HOBBY
                }

                MenuItem {
                    text: "Home"
                    iconSource: PathResolver.categoryIcon(Ne.HOME)
                    onTriggered: NoteEverywhere.category = Ne.HOME
                }

                MenuItem {
                    text: "None"
                    iconSource: PathResolver.categoryIcon(Ne.NONE)
                    onTriggered: NoteEverywhere.category = Ne.NONE
                }
            }
        }

        Item { Layout.fillWidth: true }

        SearchThemedTextField { Layout.alignment: Qt.AlignRight; Layout.fillWidth: true; Layout.maximumWidth: 400 * NoteEverywhere.ratio }
    }
}
