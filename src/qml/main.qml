import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/desktop/src/qml/desktop"
import "qrc:/mobile/src/qml/mobile"

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Note Everywhere")

    property Component desktopScreen: DesktopScreen {}
    property Component mobileScreen: MobileScreen {}

    Loader {
        anchors.fill: parent
        sourceComponent: NoteEverywhere.isMobile? mobileScreen : mobileScreen
        focus: true
    }
}

