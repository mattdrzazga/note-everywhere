import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Rectangle {
    id: root
    width: parent.width
    height: NoteEverywhere.ratio * 100
    clip: true

    property alias mouseArea: mouseArea

    //Dynamic shade
    Rectangle {
        id: shade
        x: mouseArea.pressedX - width / 2
        y: mouseArea.pressedY - height / 2
        color: "grey"
        opacity: 0.3
        width: 0; height: 0
        radius: root.width > root.height? root.width/2 : root.height/2

        states: State {
            name: "active"
            when: mouseArea.pressed && !mouseArea.moved

            PropertyChanges {
                target: shade
                width: 2 * (root.width > root.height? root.width : root.height)
                height: 2 * (root.width > root.height? root.width : root.height)
            }
        }

        transitions: Transition {
            to: "active"
            PropertyAnimation { easing.type: Easing.InOutQuad; properties: "width, height"; duration: 600 }
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

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10 * NoteEverywhere.ratio

        Image {
            anchors.verticalCenter: parent.verticalCenter
            Layout.preferredWidth: 64 * NoteEverywhere.ratio
            Layout.preferredHeight: 64 * NoteEverywhere.ratio
            source: root.ListView.isCurrentItem? PathResolver.iconFromAndroidAssets("ic_label_black_48dp.png") : PathResolver.iconFromAndroidAssets("ic_label_grey_48dp.png")
            sourceSize.width: 64 * NoteEverywhere.ratio
            sourceSize.height: 64 * NoteEverywhere.ratio
        }

        Item { Layout.preferredWidth: 10 }

        Label {
            anchors.verticalCenter: parent.verticalCenter
            Layout.fillWidth: true
            text: model.name
            elide: Text.ElideRight
            font.pointSize: 16
        }
    }
}
