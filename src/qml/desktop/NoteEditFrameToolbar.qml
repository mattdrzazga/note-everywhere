import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import "qrc:/core/src/qml/core"

ToolBar {

    property alias boldButton: boldButton
    property alias italicButton: italicButton
    property alias underlineButton: underlineButton
    property alias strikethroughButton: strikethroughButton

    TextEditActions {
        id: textEditActions
    }

    RowLayout {
        anchors.fill: parent

        ToolButton {
            id: boldButton
            action: textEditActions.boldAction
        }

        ToolButton {
            id: italicButton
            action: textEditActions.italicAction
        }

        ToolButton {
            id: underlineButton
            action: textEditActions.underlineAction
        }

        ToolButton {
            id: strikethroughButton
            action: textEditActions.strikethroughAction
        }

        Rectangle { width: 1; Layout.preferredHeight: parent.height * 0.7; color: "#133a0f" }

        ToolButton {
            id: alignLeftButton
            action: textEditActions.alignLeftAction
        }

        ToolButton {
            id: alignCenterButton
            action: textEditActions.centerHorizontallyAction
        }

        ToolButton {
            id: alignRightButton
            action: textEditActions.alignRightAction
        }

        ToolButton {
            id: alignJustifyButton
            action: textEditActions.alignJustifyAction
        }

        Rectangle { width: 1; Layout.preferredHeight: parent.height * 0.7; color: "#133a0f" }

        ToolButton {
            id: unorderedListButton
            action: textEditActions.unorderedListButton
        }

        ToolButton {
            id: orderedListButton
            action: textEditActions.orderedListButton
        }

        ToolButton {
            id: decreaseIndendButton
            action: textEditActions.decreaseIndentButton
        }

        ToolButton {
            id: increaseIndendButton
            action: textEditActions.decreaseIndentButton
        }

        Item { Layout.fillWidth: true }
    }
}

