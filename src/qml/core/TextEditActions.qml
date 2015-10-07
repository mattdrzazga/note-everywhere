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

    Action {
        id: boldAction
        iconName: "format-text-bold"
        iconSource: PathResolver.iconPath("");
        tooltip: "Bold"
        checkable: true
        shortcut: "Ctrl+o"
    }

    Action {
        id: italicAction
        iconName: "format-text-italic"
        iconSource: PathResolver.iconPath("");
        tooltip: "Italic"
        checkable: true
        shortcut: "Ctrl+i"
    }

    Action {
        id: underlineAction
        iconName: "format-text-underline"
        iconSource: PathResolver.iconPath("");
        tooltip: "Underline"
        checkable: true
        shortcut: "Ctrl+u"
    }

    Action {
        id: strikethroughAction
        iconName: "format-text-strikethrough"
        iconSource: PathResolver.iconPath("");
        tooltip: "Strikethrough"
        checkable: true
    }

    Action {
        id: alignLeftAction
        iconName: "format-justify-left"
        iconSource: PathResolver.iconPath("");
        tooltip: "Align left"
        checkable: true
        shortcut: "Ctrl+l"
        exclusiveGroup: alignmentExclusiveGroup
    }


    Action {
        id: centerHorizontallyAction
        iconName: "format-justify-center"
        iconSource: PathResolver.iconPath("");
        tooltip: "Center horizontally"
        checkable: true
        shortcut: "Ctrl+e"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: alignRightAction
        iconName: "format-justify-right"
        iconSource: PathResolver.iconPath("");
        tooltip: "Align right"
        checkable: true
        shortcut: "Ctrl+r"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: alignJustifyAction
        iconName: "format-justify-fill"
        iconSource: PathResolver.iconPath("");
        tooltip: "Justified"
        checkable: true
        shortcut: "Ctrl+j"
        exclusiveGroup: alignmentExclusiveGroup
    }

    Action {
        id: unorderedListButton
        iconName: "format-list-unordered"
        iconSource: PathResolver.iconPath("");
        tooltip: "Bullets"
        checkable: true
    }

    Action {
        id: orderedListButton
        iconName: "format-list-ordered"
        iconSource: PathResolver.iconPath("");
        tooltip: "Numbering"
        checkable: true
    }

    Action {
        id: increaseIndentButton
        iconName: "format-indent-more"
        iconSource: PathResolver.iconPath("");
        tooltip: "Increase indent"
        shortcut: "Ctrl+]"
    }

    Action {
        id: decreaseIndentButton
        iconName: "format-indent-less"
        iconSource: PathResolver.iconPath("");
        tooltip: "Decrease indent"
        shortcut: "Ctrl+["
    }

    ExclusiveGroup {
        id: alignmentExclusiveGroup
    }
}

