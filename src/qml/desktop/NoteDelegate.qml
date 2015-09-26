import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Item {
    width: parent.width
    height: 60 * NoteEverywhere.ratio

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10 * NoteEverywhere.ratio
        anchors.rightMargin: 10 * NoteEverywhere.ratio

        Label {
            Layout.preferredWidth: 50 * NoteEverywhere.ratio
            text: model.name
        }

        ToolButton {
            id: toolButton

            function onTriggeredSlot(category) {
                console.log("changing category of " + model.name)
                if (model.category !== category){
                    NoteEverywhere.model.setCategoryAt(model.index, category)
                    NoteEverywhere.sqlInterface.updateNoteCategory(model.id, category)
                }
            }

            iconSource: PathResolver.categoryIcon(model.category)
            Layout.alignment: Qt.AlignRight
            menu: Menu {
                MenuItem {
                    text: "Work"
                    iconSource: PathResolver.categoryIcon(Ne.WORK)
                    onTriggered: toolButton.onTriggeredSlot(Ne.WORK)
                }

                MenuItem {
                    text: "Entertainment"
                    iconSource: PathResolver.categoryIcon(Ne.ENTERTAINMENT)
                    onTriggered: toolButton.onTriggeredSlot(Ne.ENTERTAINMENT)
                }

                MenuItem {
                    text: "Hobby"
                    iconSource: PathResolver.categoryIcon(Ne.HOBBY)
                    onTriggered: toolButton.onTriggeredSlot(Ne.HOBBY)
                }

                MenuItem {
                    text: "Home"
                    iconSource: PathResolver.categoryIcon(Ne.HOME)
                    onTriggered: toolButton.onTriggeredSlot(Ne.HOME)
                }

                MenuItem {
                    text: "None"
                    iconSource: PathResolver.categoryIcon(Ne.NONE)
                    onTriggered: toolButton.onTriggeredSlot(Ne.NONE)
                }
            }
        }
    }
}
