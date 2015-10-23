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
    property alias searchTextField: searchTextField

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


        CategoryMenu {
            id: categoryMenu
            workCategoryButton.onTriggered: categoryButton.searchForCategory(Ne.WORK)
            entertainmentCategoryButton.onTriggered: categoryButton.searchForCategory(Ne.ENTERTAINMENT)
            hobbyCategoryButton.onTriggered: categoryButton.searchForCategory(Ne.HOBBY)
            homeCategoryButton.onTriggered: categoryButton.searchForCategory(Ne.HOME)
            noneCategoryButton.onTriggered: categoryButton.searchForCategory(Ne.NONE)
        }

        ToolButton {
            id: categoryButton
            action: noteListActions.categoryAction
            onClicked: categoryMenu.popup()

            function searchForCategory(category) {
                if (NoteEverywhere.currentCategory !== category) {
                    NoteEverywhere.currentCategory = category
                    NoteEverywhere.notesFor(searchTextField.text)
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
