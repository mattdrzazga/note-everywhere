import QtQuick 2.5
import QtQuick.Controls 1.4

Item {
    property alias boldAction: boldAction
    property alias italicAction: italicAction
    property alias underlineAction: underlineAction
    property alias strikethroughAction: strikethroughAction

    property alias alignLeftAction: alignLeftAction
    property alias centerHorizontallyAction: centerHorizontallyAction
    property alias alignRightAction: alignRightAction
    property alias alignJustifyAction: alignJustifyAction

    property alias unorderedListButton: unorderedListButton
    property alias orderedListButton: orderedListButton
    property alias decreaseIndentButton: decreaseIndentButton
    property alias increaseIndentButton: increaseIndentButton
    property alias selectFontColorButton: selectFontColorButton

    Action {
        id: boldAction
        iconSource: PathResolver.iconPath("format-text-bold");
        tooltip: "Bold"
        checkable: true
        shortcut: StandardKey.Bold
    }

    Action {
        id: italicAction
        iconSource: PathResolver.iconPath("format-text-italic");
        tooltip: "Italic"
        checkable: true
        shortcut: StandardKey.Italic
    }

    Action {
        id: underlineAction
        iconSource: PathResolver.iconPath("format-text-underline");
        tooltip: "Underline"
        checkable: true
        shortcut: StandardKey.Underline
    }

    Action {
        id: strikethroughAction
        iconSource: PathResolver.iconPath("format-text-strikethrough");
        tooltip: "Strikethrough"
        checkable: true
    }

    Action {
        id: alignLeftAction
        iconSource: PathResolver.iconPath("format-justify-left");
        tooltip: "Align left"
        checkable: true
        shortcut: "Ctrl+l"
        exclusiveGroup: alignmentExclusiveGroup
    }


    Action {
        id: centerHorizontallyAction
        iconSource: PathResolver.iconPath("format-justify-center");
        tooltip: "Center horizontally"
        checkable: true
        shortcut: "Ctrl+e"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: alignRightAction
        iconSource: PathResolver.iconPath("format-justify-right");
        tooltip: "Align right"
        checkable: true
        shortcut: "Ctrl+r"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: alignJustifyAction
        iconSource: PathResolver.iconPath("format-justify-fill");
        tooltip: "Justified"
        checkable: true
        shortcut: "Ctrl+j"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: unorderedListButton
        iconSource: PathResolver.iconPath("format-list-unordered");
        tooltip: "Bullets"
        checkable: true
    }

    Action {
        id: orderedListButton
        iconSource: PathResolver.iconPath("format-list-ordered");
        tooltip: "Numbering"
        checkable: true
    }

    Action {
        id: increaseIndentButton
        iconSource: PathResolver.iconPath("format-indent-more");
        tooltip: "Increase indent"
        shortcut: "Ctrl+]"
    }

    Action {
        id: decreaseIndentButton
        iconSource: PathResolver.iconPath("format-indent-less");
        tooltip: "Decrease indent"
        shortcut: "Ctrl+["
    }

    Action {
        id: selectFontColorButton
        iconSource: PathResolver.iconPath("gtk-select-font")
        tooltip: "Select font color"
    }

    ExclusiveGroup {
        id: alignmentExclusiveGroup
    }
}
