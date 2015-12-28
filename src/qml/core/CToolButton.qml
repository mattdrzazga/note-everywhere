import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ToolButton {
    property Item layout: undefined
    property bool _shouldBeVisible: (x + width) < layout.width
    on_ShouldBeVisibleChanged: visible = _shouldBeVisible
    objectName: "CToolButton"

    function refresh() {
        var shouldBeVisible = (x + width) < rowLayout.width
        visible = shouldBeVisible
    }
}
