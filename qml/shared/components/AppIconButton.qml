import QtQuick
import QtQuick.Controls
import qtnotesmd

Button {
    required property string image
    required property int size

    id: root
    icon.width: root.size
    icon.height: root.size
    icon.source: root.image
    icon.color: Theme.color.accent
    padding: 8
    background: Rectangle {
        color: root.hovered ? Theme.color.accent : "transparent"
        radius: 4
        opacity: 0.1
    }
}