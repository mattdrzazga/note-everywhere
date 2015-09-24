import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ToolBar {
    RowLayout {
        anchors.fill: parent
        ToolButton {
            iconName: "document-new"
            iconSource: "file:/usr/share/icons/breeze/actions/toolbar/document-new.svg"
        }
        ToolButton {
            iconName: "document-new"
            iconSource: "file:/usr/share/icons/breeze/actions/toolbar/view-refresh.svg"
        }
        ToolButton {
            iconName: "document-new"
            iconSource: "file:/home/matt/Development/GUI/qt/note-everywhere/images/flag-grey.svg"
        }

        SearchThemedTextField {Layout.alignment: Qt.AlignRight; Layout.fillWidth: true; Layout.maximumWidth: 400 }
    }
}
