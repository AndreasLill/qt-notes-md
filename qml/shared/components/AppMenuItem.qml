import QtQuick
import QtQuick.Controls

MenuItem {
    id: root

    property string hint
    property var shortcut

    contentItem: Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        color: "transparent"

        Text {
            anchors.verticalCenter: parent.verticalCenter 
            anchors.left: parent.left
            text: root.text
            color: root.focus ? palette.highlightedText : palette.text
            font.pixelSize: 14
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter 
            anchors.right: parent.right
            text: root.hint
            color: root.focus ? palette.highlightedText : palette.text
            opacity: 0.5
            font.pixelSize: 14
        }
    }

    action: Action {
        text: root.text
        shortcut: root.shortcut
        onTriggered: root.clicked()
    }
}