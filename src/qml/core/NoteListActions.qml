import QtQuick 2.5
import QtQuick.Controls 1.4

Item {

    property alias createNewNoteAction: createNewNoteAction
    property alias refreshAction: refreshAction
    property alias renameAction: renameAction
    property alias deleteAction: deleteAction

    Action {
        id: createNewNoteAction
        iconSource: PathResolver.iconPath("document-new");
        tooltip: "Create new note"
        text: "Create &note"
        shortcut: StandardKey.New
    }

    Action {
        id: refreshAction
        iconSource: PathResolver.iconPath("view-refresh");
        tooltip: "Refresh"
        text: "&Refresh"
        shortcut: StandardKey.Refresh
    }

    Action {
        id: renameAction
        text: "Rename"
        iconSource: PathResolver.iconPath("edit-rename")
        shortcut: "F2"
    }

    Action {
        id: deleteAction
        text: "Delete"
        iconSource: PathResolver.iconPath("edit-delete")
        shortcut: StandardKey.Delete
    }
}
