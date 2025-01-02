import QtQuick
import QtQuick.Controls

MenuItem {
    id: root

    required property string menuText
    property string shortcutText
    property var shortcutKey

    contentItem: Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        color: "transparent"

        Text {
            anchors.verticalCenter: parent.verticalCenter 
            anchors.left: parent.left
            text: root.menuText
            color: root.focus ? palette.highlightedText : palette.text
            font.pixelSize: 14
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter 
            anchors.right: parent.right
            text: root.shortcutText
            color: root.focus ? palette.highlightedText : palette.text
            opacity: 0.5
            font.pixelSize: 14
        }
    }

    action: Action {
        text: root.menuText
        shortcut: root.shortcutKey
        onTriggered: root.clicked()
    }
}