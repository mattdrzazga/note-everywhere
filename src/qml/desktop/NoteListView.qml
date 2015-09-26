import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {

    NoteListViewToolBar {
        id: toolbar
    }


    ListView {
        anchors.top: toolbar.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        model: NoteEverywhere.model
    }
}