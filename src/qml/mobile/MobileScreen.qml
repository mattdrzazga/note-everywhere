import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: root


    CategoryListView {
        id: categoryListView
        width: root.width > root.height? 0.5 * root.width : 0.85 * root.width
        height: root.height
        x: -width
        z: 2
    }

    Rectangle {
        anchors.fill: parent
        z: 1
        color: "black"
        opacity: categoryListView.state === "SHOWN"? 0.6 : 0

        MouseArea {
            anchors.fill: parent
            onClicked: categoryListView.hide()
            enabled: parent.opacity === 0.6
        }

        Behavior on opacity {
            PropertyAnimation {
                duration: 150
            }
        }
    }


    NoteListView {
        anchors.fill: parent
        menuButton.onClicked: categoryListView.show()
    }
}
