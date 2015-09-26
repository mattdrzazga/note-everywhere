import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/desktop/src/qml/desktop"

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Note Everywhere")


    Loader {
        anchors.fill: parent
        sourceComponent: DesktopScreen {}
        focus: true
    }
}

