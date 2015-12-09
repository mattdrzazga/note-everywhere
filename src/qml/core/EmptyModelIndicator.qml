import QtQuick 2.5
import QtQuick.Controls 1.4

Rectangle {
    color: "grey"
    opacity: 0.2

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.8
            text: "There are no notes in this category"
            wrapMode: Text.WordWrap
            font.pixelSize: 16 * NoteEverywhere.ratio
        }

        Image {
            asynchronous: true
            anchors.left: parent.left
            anchors.right: parent.right
            source: "qrc:/linux/images/linux/ic_not_interested_black_48dp.png"
        }
    }
}

