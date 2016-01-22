import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2
import QtGraphicalEffects 1.0

Item {
    // Themed ToolBar
    ToolBar {
        id: toolBar

        RowLayout {
            anchors.fill: parent
            spacing: 0

            ToolButton {
                iconSource: PathResolver.iconFromAndroidAssets("ic_menu_black_48dp.png")
            }

            ToolButton {
                iconSource: PathResolver.iconFromAndroidAssets("ic_refresh_black_48dp.png")
            }

            Item { Layout.fillWidth: true }
        }

        style: ToolBarStyle {
            panel: Rectangle {
                color: "#4caf50"

                DropShadow {
                    anchors.fill: parent
                    verticalOffset: 3
                    radius: 8.0
                    samples: 16
                    color: "#80000000"
                    source: parent
                    transparentBorder: true
                    z: -1
                }
            }
        }
    }




// Floating button
    Rectangle {
        id: floatingRect
        width: 100 * NoteEverywhere.ratio
        height: 100 * NoteEverywhere.ratio
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 32 * NoteEverywhere.ratio
        anchors.bottomMargin: 32 * NoteEverywhere.ratio
        color: "#4caf50"
        radius: 0.5 * width

        Image {
            id: name
            anchors.centerIn: parent
            width: 48 * NoteEverywhere.ratio
            height: 48 * NoteEverywhere.ratio
            source: PathResolver.iconFromAndroidAssets("ic_create_white_48dp.png")
        }
    }

    DropShadow {
        anchors.fill: floatingRect
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#80000000"
        source: floatingRect
        transparentBorder: true
    }
}
