import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "qrc:/core/src/qml/core"
import "qrc:/desktop/src/qml/desktop"

Item {
    id: root

    signal noteClicked()

    Component.onCompleted: NoteEverywhere.populateModel()


    property Component categoryListView: CategoryListView {
        onCategoryClicked: listView.positionViewAtEnd()
    }

    property Component noteListView: Item {
        NoteListViewToolBar {
            id: noteListViewToolBar
            width: parent.width
            height: 45 * NoteEverywhere.ratio

            style: ToolBarStyle {
                panel: Rectangle {
                    color: "#4caf50"

                    Rectangle {
                        color: Qt.lighter(parent.color, 1.2)
                        height: 1
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        width: parent.width
                    }
                    Rectangle {
                        z: 2 // so flickable doesn't draw on top
                        height: 1
                        width: parent.width
                        color: Qt.darker(parent.color, 1.6)
                        anchors.bottom: parent.bottom
                    }

                    Rectangle {
                        width: parent.width
                        height: 5
                        anchors.top: parent.bottom
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: "#40000000" }
                            GradientStop { position: 1 ; color: "#00000000" }
                        }
                    }
                }
            }

            createNewNoteButton.onClicked: noteListViewId.createNewNote()
        }

        NoteListView {
            id: noteListViewId
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: noteListViewToolBar.bottom
            toolBar: noteListViewToolBar
            onNoteClicked: item.noteClicked()
        }
    }

    property Component noteEditFrame: NoteEditFrame { }


    property Component stackView: StackView {
        id: rootStackView
        initialItem: noteListView
        focus: true

        Keys.onReleased: {
            if (event.key === Qt.Key_Back || (event.key === Qt.Key_Left && (event.modifiers & Qt.AltModifier))) {
                if (rootStackView.depth > 1) {
                    rootStackView.pop(noteEditFrame)
                }
            }
        }

        Connections {
            target: root
            onNoteClicked: rootStackView.push(noteEditFrame)
        }
    }


    ListView {
        id: listView
        anchors.fill: parent
        model: 2
        orientation: ListView.Horizontal
        currentIndex: 0
        snapMode: ListView.SnapOneItem
        highlightMoveDuration: 100
        delegate: Loader {
            width: root.width
            height: root.height
            sourceComponent: index === 0? categoryListView : stackView
        }
    }
}
