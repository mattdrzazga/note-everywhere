import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Loader {
    property int pixelSize: 11 * NoteEverywhere.ratio

    active: NoteEverywhere.currentCategory === Ne.NONE

    sourceComponent: Rectangle {
        color: NoteEverywhere.colors.categoryIndicator
        width: if (categoryLabel.implicitWidth < 70 * NoteEverywhere.ratio){
                   categoryLabel.implicitWidth + 10 * NoteEverywhere.ratio
               }
               else {
                   70 * NoteEverywhere.ratio
               }

        height: categoryLabel.implicitHeight

        Label {
            id: categoryLabel
            text: NoteEverywhere.categoryAsText(category)
            elide: Text.ElideRight
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 5 * NoteEverywhere.ratio
            anchors.rightMargin: 5 * NoteEverywhere.ratio
            font.pixelSize: pixelSize
        }
    }
}
