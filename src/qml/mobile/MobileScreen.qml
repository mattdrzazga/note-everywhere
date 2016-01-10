import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "qrc:/core/src/qml/core"
import "qrc:/desktop/src/qml/desktop"

Item {
    id: root

    signal noteClicked()
    signal popTextEditFrame()

    Component.onCompleted: NoteEverywhere.populateModel()

    property Component categoryListView: CategoryListView {
        onCategoryClicked: {
            root.popTextEditFrame()
            listView.positionViewAtEnd()
        }
    }

    property Component noteListView: Item {
        NoteListViewToolBar {
            id: noteListViewToolBar
            width: parent.width
            height: 90 * NoteEverywhere.ratio

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
                        z: 2
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

            searchTextField.style: TextFieldStyle {
                textColor: "black"
                padding.right: control.text !==""? (44 + 10) * NoteEverywhere.ratio : 5 * NoteEverywhere.ratio
                background: Rectangle {
                    radius: 3 * NoteEverywhere.ratio
                    implicitWidth: 144 * NoteEverywhere.ratio
                    implicitHeight: 50 * NoteEverywhere.ratio
                    border.color: control.focus === true? "#4477bb" : "darkgrey"
                    border.width: 1


                    MouseArea {
                        opacity: control.text !== ""? 1 : 0
                        width: 44 * NoteEverywhere.ratio
                        height: 44 * NoteEverywhere.ratio
                        anchors.right: parent.right
                        anchors.rightMargin: 5 * NoteEverywhere.ratio
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: control.text = ""

                        Image {
                            anchors.fill: parent
                            source: PathResolver.iconPath("edit-clear")
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
            focus: false


            Loader {
                anchors.fill: parent
                focus: true
                active: NoteEverywhere.model.size === 0
                sourceComponent: EmptyModelIndicator {}
            }
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
            onPopTextEditFrame: {
                if (rootStackView.depth > 1) {
                    rootStackView.pop(noteEditFrame)
                    rootStackView.completeTransition()
                }
            }
        }
    }


    ListView {
        id: listView
        anchors.fill: parent
        model: 2
        orientation: ListView.Horizontal
        currentIndex: 0
        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.StopAtBounds
        highlightMoveDuration: 100
        delegate: Loader {
            width: root.width
            height: root.height
            sourceComponent: index === 0? categoryListView : stackView
        }
    }
}
