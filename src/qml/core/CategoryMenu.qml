import QtQuick.Controls 1.4
import NoteEverywhere 1.0

Menu {
    property alias workCategoryButton: workCategoryButton
    property alias entertainmentCategoryButton: entertainmentCategoryButton
    property alias hobbyCategoryButton: hobbyCategoryButton
    property alias homeCategoryButton: homeCategoryButton
    property alias noneCategoryButton: noneCategoryButton

    MenuItem {
        id: workCategoryButton
        text: "&Work"
    }

    MenuItem {
        id: entertainmentCategoryButton
        text: "&Entertainment"
    }

    MenuItem {
        id: hobbyCategoryButton
        text: "&Hobby"
    }

    MenuItem {
        id: homeCategoryButton
        text: "H&ome"
    }

    MenuItem {
        id: noneCategoryButton
        text: "&None"
    }
}
