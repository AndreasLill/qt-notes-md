import QtQuick
import QtQuick.Controls
import qtnotesmd

MenuBar {
    id: root
    implicitHeight: 28

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