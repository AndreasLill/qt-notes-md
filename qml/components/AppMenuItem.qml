import QtQuick
import QtQuick.Controls
import qtnotesmd

MenuItem {
    property string hint
    property var shortcut

    id: root

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 30
        radius: 4
        color: root.focus ? Qt.lighter(Theme.color.overlay) : Theme.color.overlay
    }

    contentItem: Rectangle {
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
    }
}