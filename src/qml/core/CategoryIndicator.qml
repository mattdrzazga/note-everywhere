import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Loader {
    active: NoteEverywhere.currentCategory === Ne.NONE
    sourceComponent: Rectangle {
        color: "lightgrey"
        width: 70 * NoteEverywhere.ratio
        height: categoryLabel.implicitHeight
        Label {
            id: categoryLabel
            text: NoteEverywhere.categoryAsText(category)
            elide: Text.ElideRight
            anchors.fill: parent
            anchors.leftMargin: 5 * NoteEverywhere.ratio
            anchors.rightMargin: 5 * NoteEverywhere.ratio
            font.pixelSize: 11 * NoteEverywhere.ratio
        }
    }
}
