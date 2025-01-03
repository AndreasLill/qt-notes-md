import QtQuick
import QtQuick.Controls
import qtnotesmd

Button {
    required property string tooltip
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

    ToolTip {
        visible: root.hovered
        x: Math.round(root.width + 8)
        y: Math.round((root.height - height) / 2)
        background: Rectangle {
            color: Theme.color.tooltipBackground
            radius: 4
            border.color: Theme.color.divider
            border.width: 1
        }
        contentItem: Text {
            padding: 4
            text: root.tooltip
            color: Theme.color.tooltipText
            font.pixelSize: 13
        }
    }
}