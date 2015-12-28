import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import "qrc:/core/src/qml/core"

ToolBar {

    property alias boldAction: textEditActions.boldAction
    property alias italicAction: textEditActions.italicAction
    property alias underlineAction: textEditActions.underlineAction
    property alias strikethroughAction: textEditActions.strikethroughAction
    property alias alignLeftAction: textEditActions.alignLeftAction
    property alias alignCenterAction: textEditActions.centerHorizontallyAction
    property alias alignRightAction: textEditActions.alignRightAction
    property alias alignJustifyAction: textEditActions.alignJustifyAction
    property alias unorderedListAction: textEditActions.unorderedListAction
    property alias orderedListAction: textEditActions.orderedListAction
    property alias decreaseIndentAction: textEditActions.decreaseIndentAction
    property alias increaseIndentAction: textEditActions.increaseIndentAction
    property alias selectFontColorAction: textEditActions.selectFontColorAction
    property alias fontColorIndicatorRectangle: fontColorIndicatorRectangle


    // If this ToolBar was assigned to 'toolBar' property in 'ApplicationWindow' this call would not be necessary.
    // This function prevents CToolButtons to be incorrectly hidden/shown when application starts and application window doesn't have enough width.
    // Feel free to comment out this section if you plan to assign this component to 'AplicationWindow' 'toolBar' property.
    //***********************************************************
    Component.onCompleted: {
        for (var i = 0; i < rowLayout.children.length; ++i){
            var child = rowLayout.children[i]
            if (child.objectName === "CToolButton") {
                child.refresh()
            }
        }
    }
    //***********************************************************

    TextEditActions { id: textEditActions }

    Loader {
        active: (selectFontColorButton.x + selectFontColorButton.width) >= rowLayout.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: rowLayout.right
        anchors.rightMargin: -5 * NoteEverywhere.ratio
        width: 20 * NoteEverywhere.ratio
        height: 20 * NoteEverywhere.ratio
        asynchronous: true
        z: 1
        sourceComponent: ToolButton {
            menu: Menu {
                MenuItem { action: textEditActions.boldAction;                  visible: !boldButton.visible }
                MenuItem { action: textEditActions.italicAction;                visible: !italicButton.visible }
                MenuItem { action: textEditActions.underlineAction;             visible: !underlineButton.visible }
                MenuItem { action: textEditActions.strikethroughAction;         visible: !strikethroughButton.visible }

                MenuSeparator { visible: !alignLeftButton.visible }

                MenuItem { action: textEditActions.alignLeftAction;             visible: !alignLeftButton.visible }
                MenuItem { action: textEditActions.centerHorizontallyAction;    visible: !alignCenterButton.visible }
                MenuItem { action: textEditActions.alignRightAction;            visible: !alignRightButton.visible }
                MenuItem { action: textEditActions.alignJustifyAction;          visible: !alignJustifyButton.visible }

                MenuSeparator { visible: !unorderedListButton.visible }

                MenuItem { action: textEditActions.unorderedListAction;         visible: !unorderedListButton.visible }
                MenuItem { action: textEditActions.orderedListAction;           visible: !orderedListButton.visible }
                MenuItem { action: textEditActions.increaseIndentAction;        visible: !increaseIndentButton.visible }
                MenuItem { action: textEditActions.decreaseIndentAction;        visible: !decreaseIndentButton.visible }

                MenuItem { action: textEditActions.selectFontColorAction;       visible: !selectFontColorButton.visible }
            }
        }
    }


    RowLayout {
        id: rowLayout
        anchors.fill: parent

        CToolButton {
            id: boldButton
            action: textEditActions.boldAction
            layout: rowLayout
        }

        CToolButton {
            id: italicButton
            action: textEditActions.italicAction
            layout: rowLayout
        }

        CToolButton {
            id: underlineButton
            action: textEditActions.underlineAction
            layout: rowLayout
        }

        CToolButton {
            id: strikethroughButton
            action: textEditActions.strikethroughAction
            layout: rowLayout
        }

        Rectangle { width: 1; Layout.preferredHeight: parent.height * 0.7; color: NoteEverywhere.colors.separator; visible: alignLeftButton.visible }

        CToolButton {
            id: alignLeftButton
            action: textEditActions.alignLeftAction
            layout: rowLayout
        }

        CToolButton {
            id: alignCenterButton
            action: textEditActions.centerHorizontallyAction
            layout: rowLayout
        }

        CToolButton {
            id: alignRightButton
            action: textEditActions.alignRightAction
            layout: rowLayout
        }

        CToolButton {
            id: alignJustifyButton
            action: textEditActions.alignJustifyAction
            layout: rowLayout
        }

        Rectangle { width: 1; Layout.preferredHeight: parent.height * 0.7; color: NoteEverywhere.colors.separator; visible: alignJustifyButton.visible }

        CToolButton {
            id: unorderedListButton
            action: textEditActions.unorderedListAction
            layout: rowLayout
        }

        CToolButton {
            id: orderedListButton
            action: textEditActions.orderedListAction
            layout: rowLayout
        }

        CToolButton {
            id: increaseIndentButton
            action: textEditActions.increaseIndentAction
            layout: rowLayout
        }

        CToolButton {
            id: decreaseIndentButton
            action: textEditActions.decreaseIndentAction
            layout: rowLayout
        }

        CToolButton {
            id: selectFontColorButton
            action: textEditActions.selectFontColorAction
            layout: rowLayout

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
