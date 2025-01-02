import QtQuick
import QtQuick.Controls
import qtnotesmd

MenuBar {
    id: root
    implicitHeight: 28
    contentItem: Rectangle {
        color: palette.window

        Rectangle {
            color: palette.mid
            height: 1
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }

    signal fileSave
    signal fileQuit

    Menu {
        id: fileMenu
        title: "&File"

        AppMenuItem {
            menuText: "Save"
            shortcutText: "CTRL+S"
            shortcutKey: StandardKey.Save
            onClicked: root.fileSave()
        }
        AppMenuItem {
            menuText: "Quit"
            shortcutText: "CTRL+Q"
            shortcutKey: StandardKey.Quit
            onClicked: root.fileQuit()
        }
    }
}