import QtQuick
import QtQuick.Controls
import qtnotesmd

Button {
    required property string image
    required property color hoverColor
    property int size: 20

    id: root
    icon.width: root.size
    icon.height: root.size
    icon.source: root.image
    icon.color: Theme.color.text
    padding: 8
    background: Rectangle {
        color: root.hovered ? root.hoverColor : "transparent"
        radius: 4
    }
}