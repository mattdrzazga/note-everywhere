import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import NoteEverywhere 1.0

Rectangle {
    id: root
    visible: false
    x: -width


    Keys.onBackPressed: hide()


    function show() {
        state = "SHOWN"
        forceActiveFocus()
    }

    function hide() {
        state = ""
    }


    ListView {
        id: listView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        boundsBehavior: Flickable.StopAtBounds
        delegate: CategoryDelegate{
            color: ListView.isCurrentItem? NoteEverywhere.colors.currentItem : "white"

            mouseArea.onClicked: {
                listView.currentIndex = index
                root.hide()
            }
        }

        model: ListModel {
            ListElement { name: "All Notes"; category: Ne.NONE }
            ListElement { name: "Work"; category: Ne.WORK }
            ListElement { name: "Entertainment"; category: Ne.ENTERTAINMENT }
            ListElement { name: "Hobby"; category: Ne.HOBBY }
            ListElement { name: "Home"; category: Ne.HOME }
        }

        onCurrentIndexChanged: {
            var category = listView.model.get(currentIndex).category
            if (NoteEverywhere.currentCategory !== category) {
                NoteEverywhere.currentCategory = category
                NoteEverywhere.searchNotes()
            }
        }
    }

    states: State {
        name: "SHOWN"
        PropertyChanges {
            target: root
            visible: true
            x: 0
        }
    }

    transitions: Transition {
        reversible: true
        to: "SHOWN"

        SequentialAnimation {
            PropertyAnimation {
                target: root
                properties: "visible"
                duration: 0
            }

            PropertyAnimation {
                target: root
                easing.type: Easing.InOutQuad
                properties: "x"
                duration: 150
            }
        }
    }
}
