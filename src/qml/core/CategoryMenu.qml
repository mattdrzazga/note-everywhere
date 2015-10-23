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
        iconSource: PathResolver.categoryIcon(Ne.WORK)
    }

    MenuItem {
        id: entertainmentCategoryButton
        text: "&Entertainment"
        iconSource: PathResolver.categoryIcon(Ne.ENTERTAINMENT)
    }

    MenuItem {
        id: hobbyCategoryButton
        text: "&Hobby"
        iconSource: PathResolver.categoryIcon(Ne.HOBBY)
    }

    MenuItem {
        id: homeCategoryButton
        text: "H&ome"
        iconSource: PathResolver.categoryIcon(Ne.HOME)
    }

    MenuItem {
        id: noneCategoryButton
        text: "&None"
        iconSource: PathResolver.categoryIcon(Ne.NONE)
    }
}
