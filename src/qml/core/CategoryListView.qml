import QtQuick 2.5
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Rectangle {

    ListView {
        id: listView
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        highlightMoveVelocity: 1000
        highlightMoveDuration: 10
        focus: true
        highlight: Rectangle { color: NoteEverywhere.colors.currentItem }

        delegate: CategoryDelegate {
            mouseArea.onClicked: {
                listView.currentIndex = index
            }
        }

        onCurrentIndexChanged: {
            var category = listView.model.get(currentIndex).category
            if (NoteEverywhere.currentCategory !== category) {
                NoteEverywhere.currentCategory = category
                NoteEverywhere.searchNotes()
            }
        }

        model: ListModel{
            ListElement { name: "All Notes"; category: Ne.NONE }
            ListElement { name: "Work"; category: Ne.WORK }
            ListElement { name: "Entertainment"; category: Ne.ENTERTAINMENT }
            ListElement { name: "Hobby"; category: Ne.HOBBY }
            ListElement { name: "Home"; category: Ne.HOME }
        }
    }
}
