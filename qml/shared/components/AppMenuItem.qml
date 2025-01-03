import QtQuick
import QtQuick.Controls
import qtnotesmd

MenuItem {
    property string hint
    property var shortcut

    id: root

    background: Rectangle {
        color: root.focus ? Qt.lighter(Theme.color.menuBackground) : Theme.color.menuBackground
    }

    contentItem: Rectangle {
        anchors.fill: parent
        color: "transparent"

        Text {
            anchors.verticalCenter: parent.verticalCenter 
            anchors.left: parent.left
            leftPadding: 8
            text: root.text
            color: Theme.color.text
            font.pixelSize: 14
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter 
            anchors.right: parent.right
            rightPadding: 8
            text: root.hint
            color: Theme.color.text
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