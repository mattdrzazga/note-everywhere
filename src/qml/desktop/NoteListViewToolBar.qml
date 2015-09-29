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
            text: "Create &note"
        }
        ToolButton {
            iconName: "view-refresh"
            iconSource: PathResolver.iconPath("view-refresh");
            tooltip: "Refresh"
            text: "&Refresh"
            onClicked: NoteEverywhere.notesFor(searchTextField.text)
        }
        ToolButton {
            id: categoryButton

            function searchForCategory(category) {
                NoteEverywhere.currentCategory = category
                NoteEverywhere.notesFor(searchTextField.text)
            }

            tooltip: "Select category"
            text: "C&ategory"
            iconSource: PathResolver.categoryIcon(NoteEverywhere.currentCategory)
            menu: Menu {
                MenuItem {
                    text: "&Work"
                    iconSource: PathResolver.categoryIcon(Ne.WORK)
                    onTriggered: categoryButton.searchForCategory(Ne.WORK)
                }

                MenuItem {
                    text: "&Entertainment"
                    iconSource: PathResolver.categoryIcon(Ne.ENTERTAINMENT)
                    onTriggered: categoryButton.searchForCategory(Ne.ENTERTAINMENT)
                }

                MenuItem {
                    text: "&Hobby"
                    iconSource: PathResolver.categoryIcon(Ne.HOBBY)
                    onTriggered: categoryButton.searchForCategory(Ne.HOBBY)
                }

                MenuItem {
                    text: "H&ome"
                    iconSource: PathResolver.categoryIcon(Ne.HOME)
                    onTriggered: categoryButton.searchForCategory(Ne.HOME)
                }

                MenuItem {
                    text: "&None"
                    iconSource: PathResolver.categoryIcon(Ne.NONE)
                    onTriggered: categoryButton.searchForCategory(Ne.NONE)
                }
            }
        }

        Item { Layout.fillWidth: true }

        SearchThemedTextField {
            id: searchTextField
            Layout.alignment: Qt.AlignRight
            Layout.maximumWidth: 400 * NoteEverywhere.ratio
            Layout.fillWidth: true

            onTextChanged: {
                NoteEverywhere.notesFor(text)
            }
        }
    }
}
