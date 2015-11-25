import QtQuick 2.5
import QtQuick.Controls 1.4

Item {

    ListView {
        id: listView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        delegate: CategoryDelegate {
            mouseArea.onClicked: listView.currentIndex = index
        }

        highlightMoveVelocity: 1000
        highlightMoveDuration: 10

        focus: true

        Rectangle {
            anchors.fill: parent
            z: -1
        }

        highlight: Rectangle {color: "grey"}

        model: ListModel{
            ListElement { name: "Work" }

            ListElement { name: "Entertainment" }

            ListElement { name: "Hobby" }

            ListElement { name: "Home" }

            ListElement { name: "All Notes" }
        }
    }
}
