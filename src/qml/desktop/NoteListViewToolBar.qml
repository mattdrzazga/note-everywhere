import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import NoteEverywhere 1.0
import "qrc:/core/src/qml/core"

ToolBar {
    id: toolBar
    property alias createNewNoteButton: createNewNoteButton
    property alias noteListActions: noteListActions

    NoteListActions {
        id: noteListActions
    }

    RowLayout {
        anchors.fill: parent

        ToolButton {
            id: createNewNoteButton
            action: noteListActions.createNewNoteAction
        }

        ToolButton {
            action: noteListActions.refreshAction
            onClicked: NoteEverywhere.notesFor(searchTextField.text)
        }

        ToolButton {
            id: categoryButton
            action: noteListActions.categoryAction

            function searchForCategory(category) {
                if (NoteEverywhere.currentCategory !== category) {
                    NoteEverywhere.currentCategory = category
                    NoteEverywhere.notesFor(searchTextField.text)
                }
            }

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
