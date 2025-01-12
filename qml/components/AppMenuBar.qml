import QtQuick
import QtQuick.Controls
import qtnotesmd

MenuBar {
    id: root

    background: Rectangle {
        implicitHeight: 30
        color: Theme.color.surface

        Rectangle {
            color: Qt.lighter(Theme.color.surface)
            height: 1
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }

    delegate: MenuBarItem {
        id: menuBarItem

        background: Rectangle {
            implicitHeight: 30
            color: menuBarItem.highlighted ? Qt.lighter(Theme.color.surface) : "transparent"
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