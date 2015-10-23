import QtQuick 2.5
import QtQuick.Controls 1.4

Item {

    property alias createNewNoteAction: createNewNoteAction
    property alias refreshAction: refreshAction
    property alias categoryAction: categoryAction
    property alias renameAction: renameAction
    property alias deleteAction: deleteAction

    Action {
        id: createNewNoteAction
        iconName: "document-new"
        iconSource: PathResolver.iconPath("document-new");
        tooltip: "Create new note"
        text: "Create &note"
        shortcut: StandardKey.New
    }

    Action {
        id: refreshAction
        iconName: "view-refresh"
        iconSource: PathResolver.iconPath("view-refresh");
        tooltip: "Refresh"
        text: "&Refresh"
        shortcut: StandardKey.Refresh
    }

    Action {
        id: categoryAction
        tooltip: "Select category"
        text: "C&ategory"
        iconSource: PathResolver.categoryIcon(NoteEverywhere.currentCategory)
    }

    Action {
        id: renameAction
        text: "Rename"
        iconName: "document-edit"
        shortcut: "F2"
    }

    Action {
        id: deleteAction
        text: "Delete"
        iconName: "edit-delete"
        shortcut: StandardKey.Delete
    }
}
