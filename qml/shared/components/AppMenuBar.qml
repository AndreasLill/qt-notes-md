import QtQuick
import QtQuick.Controls

MenuBar {
    id: root
    implicitHeight: 28

    signal fileSave
    signal fileQuit

    Menu {
        id: fileMenu
        title: "&File"

        MenuItem {
            action: Action {
                text: "Save"
                shortcut: StandardKey.Save
                onTriggered: root.fileSave()
            }
        }
        MenuItem {
            action: Action {
                text: "Quit"
                shortcut: StandardKey.Quit
                onTriggered: root.fileQuit()
            }
        }
    }
}