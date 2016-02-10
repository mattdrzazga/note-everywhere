import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: root

    property Component noteListView: NoteListView {
        menuButton.onClicked: categoryListView.show()
        onNoteClicked: {
            if (!stackView.busy) {
                stackView.push(noteEditFrame)
            }
        }
    }

    property Component noteEditFrame: NoteEditFrame {
        onPreviousPage: {
            if (!stackView.busy) {
                stackView.pop()
            }
        }
    }


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

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: noteListView
        focus: true
        Keys.onBackPressed: {
            if (stackView.depth > 1) {
                pop()
            }
            else {
                Qt.quit()
            }
        }
    }
}
