import QtQuick 2.5
import QtQuick.Controls 1.4

Item {

    NoteEditFrameToolbar {
        id: noteEditFrameToolbar
    }

    TextArea {
        width: parent.width
        anchors.top: noteEditFrameToolbar.bottom
        anchors.bottom: parent.bottom
        frameVisible: false
    }
}
