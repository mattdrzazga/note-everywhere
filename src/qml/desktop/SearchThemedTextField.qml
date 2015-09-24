import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TextField {
    placeholderText: "Search note"
    style: TextFieldStyle {
        textColor: "black"
        padding.right: control.text !==""? 22 + 10 : 5
        background: Rectangle {
            radius: 3
            implicitWidth: 144
            implicitHeight: 25
            border.color: control.focus === true? "#4477bb" : "darkgrey"
            border.width: 1


            MouseArea {
                opacity: control.text !== ""? 1 : 0
                width: 22
                height: 22
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                onClicked: control.text = ""

                Image {
                    anchors.fill: parent
                    source: "file:/usr/share/icons/breeze/actions/toolbar/edit-clear.svg"
                }
            }
        }
    }
}
