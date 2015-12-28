import QtQuick 2.5
import QtQuick.Controls 1.4

Item {
    id: root

//    property Component categoryListView : Rectangle {
//        color: "red"
//        Component.onCompleted: console.log("categoryListView created")
//    }

//    property Component noteListView : Rectangle {
//        color: "green"
//        Component.onCompleted: console.log("noteListView created")

//        Button {
//            anchors.centerIn: parent
//            text: "Click Me"
//        }
//    }

//    ListView {
//        id: listView
//        anchors.fill: parent
//        orientation: Qt.Horizontal
//        model: 2
//        snapMode: ListView.SnapOneItem
//        highlightFollowsCurrentItem: false

//        delegate: Loader {
//            width: (index === 0)? root.width * 0.8 : root.width
//            height: root.height
//            sourceComponent: (index === 0)? categoryListView : noteListView
//        }
//    }
}

