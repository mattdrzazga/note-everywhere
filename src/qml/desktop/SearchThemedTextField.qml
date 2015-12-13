import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TextField {
    placeholderText: "Search note"
    style: TextFieldStyle {
        textColor: "black"
        padding.right: control.text !==""? (22 + 10) * NoteEverywhere.ratio : 5 * NoteEverywhere.ratio
        background: Rectangle {
            radius: 3 * NoteEverywhere.ratio
            implicitWidth: 144 * NoteEverywhere.ratio
            implicitHeight: 25 * NoteEverywhere.ratio
            border.color: control.focus === true? "#4477bb" : "darkgrey"
            border.width: 1


            MouseArea {
                opacity: control.text !== ""? 1 : 0
                width: 22 * NoteEverywhere.ratio
                height: 22 * NoteEverywhere.ratio
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
}
