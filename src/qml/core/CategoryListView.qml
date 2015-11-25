import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Item {

    ListView {
        id: listView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        delegate: CategoryDelegate {
            mouseArea.onClicked: {
                listView.currentIndex = index
                if (NoteEverywhere.currentCategory !== category) {
                    NoteEverywhere.currentCategory = category
                    NoteEverywhere.notesFor("")
                }
            }
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
            ListElement { name: "Work"; category: Ne.WORK }
            ListElement { name: "Entertainment"; category: Ne.ENTERTAINMENT }
            ListElement { name: "Hobby"; category: Ne.HOBBY }
            ListElement { name: "Home"; category: Ne.HOME }
            ListElement { name: "All Notes"; category: Ne.NONE }
        }
    }
}
