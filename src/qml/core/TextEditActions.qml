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

    property alias unorderedListAction: unorderedListAction
    property alias orderedListAction: orderedListAction
    property alias decreaseIndentAction: decreaseIndentAction
    property alias increaseIndentAction: increaseIndentAction
    property alias selectFontColorAction: selectFontColorAction

    Action {
        id: boldAction
        iconSource: PathResolver.iconPath("format-text-bold");
        text: "Bold"
        tooltip: "Bold"
        checkable: true
        shortcut: StandardKey.Bold
    }

    Action {
        id: italicAction
        iconSource: PathResolver.iconPath("format-text-italic");
        text: "Italic"
        tooltip: "Italic"
        checkable: true
        shortcut: StandardKey.Italic
    }

    Action {
        id: underlineAction
        iconSource: PathResolver.iconPath("format-text-underline");
        text: "Underline"
        tooltip: "Underline"
        checkable: true
        shortcut: StandardKey.Underline
    }

    Action {
        id: strikethroughAction
        iconSource: PathResolver.iconPath("format-text-strikethrough");
        text: "Strikethrough"
        tooltip: "Strikethrough"
        checkable: true
    }

    Action {
        id: alignLeftAction
        iconSource: PathResolver.iconPath("format-justify-left");
        text: "Align Left"
        tooltip: "Align left"
        checkable: true
        shortcut: "Ctrl+l"
        exclusiveGroup: alignmentExclusiveGroup
    }


    Action {
        id: centerHorizontallyAction
        iconSource: PathResolver.iconPath("format-justify-center");
        text: "Center Horizontally"
        tooltip: "Center horizontally"
        checkable: true
        shortcut: "Ctrl+e"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: alignRightAction
        iconSource: PathResolver.iconPath("format-justify-right");
        text: "Align Right"
        tooltip: "Align right"
        checkable: true
        shortcut: "Ctrl+r"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: alignJustifyAction
        iconSource: PathResolver.iconPath("format-justify-fill");
        text: "Justified"
        tooltip: "Justified"
        checkable: true
        shortcut: "Ctrl+j"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: unorderedListAction
        iconSource: PathResolver.iconPath("format-list-unordered");
        text: "Bullets"
        tooltip: "Bullets"
        checkable: true
    }

    Action {
        id: orderedListAction
        iconSource: PathResolver.iconPath("format-list-ordered");
        text: "Numbering"
        tooltip: "Numbering"
        checkable: true
    }

    Action {
        id: increaseIndentAction
        iconSource: PathResolver.iconPath("format-indent-more");
        text: "Increase Indent"
        tooltip: "Increase indent"
        shortcut: "Ctrl+]"
    }

    Action {
        id: decreaseIndentAction
        iconSource: PathResolver.iconPath("format-indent-less");
        text: "Decrease Indent"
        tooltip: "Decrease indent"
        shortcut: "Ctrl+["
    }

    Action {
        id: selectFontColorAction
        iconSource: PathResolver.iconPath("gtk-select-font")
        text: "Select Font Color"
        tooltip: "Select font color"
    }

    ExclusiveGroup {
        id: alignmentExclusiveGroup
    }
}
