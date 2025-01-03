import QtQuick
import QtQuick.Controls

MenuBar {
    id: root
    implicitHeight: 28
    background: Rectangle {
        color: palette.window

        Rectangle {
            color: palette.mid
            height: 1
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
    delegate: MenuBarItem {
        id: menuBarItem

        background: Rectangle {
            color: menuBarItem.highlighted ? palette.highlight : "transparent"
        }
        contentItem: Text {
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: menuBarItem.text
            font: menuBarItem.font
            color: menuBarItem.highlighted ? palette.highlightedText : palette.text
        }
        
    }
}