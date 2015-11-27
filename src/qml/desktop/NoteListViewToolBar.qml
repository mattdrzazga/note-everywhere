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
            onClicked: NoteEverywhere.searchNotes()
        }

        Item { Layout.fillWidth: true }

        SearchThemedTextField {
            id: searchTextField
            Layout.alignment: Qt.AlignRight
            Layout.maximumWidth: 400 * NoteEverywhere.ratio
            Layout.fillWidth: true

            onTextChanged: NoteEverywhere.searchQuery = text
        }
    }
}
