import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Loader {
    property int pixelSize: 11 * NoteEverywhere.ratio
    property int preferredWidth: 70 * NoteEverywhere.ratio

    property int _margin: Math.round(10 * NoteEverywhere.ratio)
    property int _2margin: 2 * _margin

    active: NoteEverywhere.currentCategory === Ne.NONE

    sourceComponent: Rectangle {
        color: NoteEverywhere.colors.categoryIndicator
        width: if (categoryLabel.implicitWidth <= preferredWidth - _2margin ) {
                   categoryLabel.implicitWidth + _2margin
               }
               else {
                   preferredWidth
               }

        height: categoryLabel.implicitHeight + 4 * NoteEverywhere.ratio

        Label {
            id: categoryLabel
            text: NoteEverywhere.categoryAsText(category)
            elide: Text.ElideRight
            anchors {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
                leftMargin: _margin
                rightMargin: _margin
            }

            font.pixelSize: pixelSize
        }
    }
}
