import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import NoteEverywhere 1.0

ToolBar {
    id: toolBar
    signal categoryChanged(int category)

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
            id: categoryButton

            function onTriggeredSlot(category) {
                categoryButton.iconSource = PathResolver.categoryIcon(category)
                toolBar.categoryChanged(category)
            }

            tooltip: "Select category"
            iconSource: "qrc:/linux/images/linux/flag-grey.svg"
            menu: Menu {
                MenuItem {
                    id: workCategory
                    text: "Work"
                    iconSource: PathResolver.categoryIcon(Ne.WORK)
                    onTriggered: categoryButton.onTriggeredSlot(Ne.WORK)
                }

                MenuItem {
                    id: entertainmentCategory
                    text: "Entertainment"
                    iconSource: PathResolver.categoryIcon(Ne.ENTERTAINMENT)
                    onTriggered: categoryButton.onTriggeredSlot(Ne.ENTERTAINMENT)
                }

                MenuItem {
                    id: hobbyCategory
                    text: "Hobby"
                    iconSource: PathResolver.categoryIcon(Ne.HOBBY)
                    onTriggered: categoryButton.onTriggeredSlot(Ne.HOBBY)
                }

                MenuItem {
                    id: homeCategory
                    text: "Home"
                    iconSource: PathResolver.categoryIcon(Ne.HOME)
                    onTriggered: categoryButton.onTriggeredSlot(Ne.HOME)
                }

                MenuItem {
                    id: noneCategory
                    text: "None"
                    iconSource: PathResolver.categoryIcon(Ne.NONE)
                    onTriggered: categoryButton.onTriggeredSlot(Ne.NONE)
                }
            }
        }

        Item { Layout.fillWidth: true }

        SearchThemedTextField { Layout.alignment: Qt.AlignRight; Layout.fillWidth: true; Layout.maximumWidth: 400 }
    }
}
