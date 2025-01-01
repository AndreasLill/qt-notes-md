import QtQuick
import QtQuick.Controls
import qtnotesmd

MenuItem {
    id: root

    required property string menuText
    property string shortcutText
    property var shortcutKey
    signal clicked

    background: Rectangle {
        color: root.hovered ? Qt.lighter(Theme.current.background) : "transparent"
    }
    contentItem: Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        color: "transparent"

        Text {
            anchors.verticalCenter: parent.verticalCenter 
            anchors.left: parent.left
            text: root.menuText
            color: Theme.current.text
            font.pixelSize: 14
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter 
            anchors.right: parent.right
            text: root.shortcutText
            color: Theme.colorWithAlpha(Theme.current.text, 0.5)
            font.pixelSize: 14
        }
    }

    action: Action {
        text: root.menuText
        shortcut: root.shortcutKey
        onTriggered: root.clicked()
    }
}