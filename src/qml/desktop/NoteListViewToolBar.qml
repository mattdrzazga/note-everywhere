import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ToolBar {
    RowLayout {
        anchors.fill: parent
        ToolButton {
            id: createNewNoteButton
            iconName: "document-new"
//            iconSource: PathResolver.iconPath("document-new");
            tooltip: "Create new note"
        }
        ToolButton {
            iconName: "view-refresh"
            iconSource: PathResolver.iconPath("view-refresh");
            tooltip: "Refresh"
        }
        ToolButton {
            tooltip: "Select category"
            iconSource: "qrc:/linux/images/linux/flag-grey.svg"
            onClicked: iconSource = "file:/home/matt/Development/GUI/qt/note-everywhere/images/linux/flag-red.svg"
        }

        Item { Layout.fillWidth: true }

        SearchThemedTextField { Layout.alignment: Qt.AlignRight; Layout.fillWidth: true; Layout.maximumWidth: 400 }
    }
}
