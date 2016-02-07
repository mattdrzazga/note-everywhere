import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtGraphicalEffects 1.0
import "qrc:/core/src/qml/core"

Item {
    id: root
    width: parent.width
    height: 180 * NoteEverywhere.ratio

    property alias mouseArea: mouseArea

    // Main Rectangle component
    Rectangle {
        id: rootRect
        width: parent.width * 0.95
        height: parent.height * 0.90
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true

        //Dynamic shade
        Rectangle {
            id: shade
            x: mouseArea.pressedX - width / 2
            y: mouseArea.pressedY - height / 2
            color: "grey"
            opacity: 0.3
            width: 0
            height: 0
            radius: rootRect.width > rootRect.height? rootRect.width/2 : rootRect.height/2

            states: State {
                name: "active"
                when: mouseArea.pressed && !mouseArea.moved

                PropertyChanges {
                    target: shade
                    width: 2 * (rootRect.width > rootRect.height? rootRect.width : rootRect.height)
                    height: 2 * (rootRect.width > rootRect.height? rootRect.width : rootRect.height)
                }
            }

            transitions: Transition {
                to: "active"

                PropertyAnimation { easing.type: Easing.InOutQuad; properties: "width, height"; duration: 1000 }
            }
        }

        // MouseArea to handle user touch input
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            property bool moved: false
            property int pressedX: 0
            property int pressedY: 0

            onPressed: {
                moved = false
                pressedX = mouseX
                pressedY = mouseY
            }

            onPositionChanged: {
                if (Math.abs(pressedX - mouse.x) > 0.20 * width)
                    moved = true
                else if (Math.abs(pressedY - mouse.y) > 0.20 * height)
                    moved = true
            }
            onReleased: moved = false
        }


        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10 * NoteEverywhere.ratio

            Label {
                font.pointSize: 20
                Layout.fillWidth: true
                elide: Text.ElideRight
                text: model.name
            }

            Label {
                font.pointSize: 18
                Layout.fillWidth: true
                elide: Text.ElideRight
                text: model.lastModificationDateTime.toLocaleString(Qt.locale(), Locale.ShortFormat)
            }
        }

        CategoryIndicator {
            anchors.right: parent.right
            anchors.rightMargin: 10 * NoteEverywhere.ratio
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10 * NoteEverywhere.ratio
            pixelSize: 30 * NoteEverywhere.ratio
            preferredWidth: 240 * NoteEverywhere.ratio
        }
    }

    DropShadow {
        anchors.fill: rootRect
        horizontalOffset: 2
        verticalOffset: 3
        radius: 8.0
        samples: 16
        cached: true
        color: "lightgrey"
        source: rootRect
    }

    DropShadow {
        anchors.fill: rootRect
        horizontalOffset: -2
        verticalOffset: 3
        radius: 8.0
        samples: 16
        cached: true
        color: "lightgrey"
        source: rootRect
    }
}
