import QtQuick
import QtQuick.Controls
import qtnotesmd

MenuBar {
    id: root
    implicitHeight: 28
    background: Rectangle {
        color: Theme.color.menuBackground

        Rectangle {
            color: Theme.color.divider
            height: 1
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
    delegate: MenuBarItem {
        id: menuBarItem

        background: Rectangle {
            color: menuBarItem.highlighted ? Qt.lighter(Theme.color.menuBackground) : "transparent"
        }
        contentItem: Text {
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: menuBarItem.text
            font: menuBarItem.font
            color: Theme.color.text
        }
    }
}