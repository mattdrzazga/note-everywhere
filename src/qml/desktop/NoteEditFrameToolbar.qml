import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import "qrc:/core/src/qml/core"

ToolBar {

    property alias boldButton: boldButton
    property alias italicButton: italicButton
    property alias underlineButton: underlineButton
    property alias strikethroughButton: strikethroughButton
    property alias alignLeftButton: alignLeftButton
    property alias alignCenterButton: alignCenterButton
    property alias alignRightButton: alignRightButton
    property alias alignJustifyButton: alignJustifyButton
    property alias unorderedListButton: unorderedListButton
    property alias orderedListButton: orderedListButton
    property alias decreaseIndentButton: decreaseIndentButton
    property alias increaseIndentButton: increaseIndentButton
    property alias alignLeftAction: textEditActions.alignLeftAction
    property alias centerHorizontallyAction: textEditActions.centerHorizontallyAction
    property alias alignRightAction: textEditActions.alignRightAction
    property alias alignJustifyAction: textEditActions.alignJustifyAction
    property alias selectFontColorButton: selectFontColorButton
    property alias fontColorIndicatorRectangle: fontColorIndicatorRectangle


    TextEditActions {
        id: textEditActions
    }

    RowLayout {
        id: rowLayout
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

        Rectangle { width: 1; Layout.preferredHeight: parent.height * 0.7; color: NoteEverywhere.colors.separator }

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

        Rectangle { width: 1; Layout.preferredHeight: parent.height * 0.7; color: NoteEverywhere.colors.separator }

        ToolButton {
            id: unorderedListButton
            action: textEditActions.unorderedListAction
        }

        ToolButton {
            id: orderedListButton
            action: textEditActions.orderedListAction
        }

        ToolButton {
            id: increaseIndentButton
            action: textEditActions.increaseIndentAction
        }

        ToolButton {
            id: decreaseIndentButton
            action: textEditActions.decreaseIndentAction
        }

        ToolButton {
            id: selectFontColorButton
            action: textEditActions.selectFontColorAction

            Rectangle {
                id: fontColorIndicatorRectangle
                width: parent.width * 0.8
                height: 3 * NoteEverywhere.ratio
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 3 * NoteEverywhere.ratio
            }
        }

        Item { Layout.fillWidth: true }
    }
}

