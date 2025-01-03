import QtQuick
import QtQuick.Controls
import qtnotesmd

ToolTip {
    enum Direction {
        Left = 0,
        Right = 1,
        Top = 2,
        Bottom = 3
    }

    property int direction: AppToolTip.Direction.Right
    property int margin: 8

    id: root
    x: switch(direction) {
        case AppToolTip.Direction.Left: return Math.round(-root.width - root.margin) 
        case AppToolTip.Direction.Right: return Math.round(parent.width + root.margin)
        case AppToolTip.Direction.Top: return Math.round((parent.width - root.width) / 2)
        case AppToolTip.Direction.Bottom: return Math.round((parent.width - root.width) / 2)
    }
    y: switch(direction) {
        case AppToolTip.Direction.Left: return Math.round((parent.height - height) / 2)
        case AppToolTip.Direction.Right: return Math.round((parent.height - height) / 2)
        case AppToolTip.Direction.Top: return Math.round(-root.height - root.margin)
        case AppToolTip.Direction.Bottom: return Math.round(parent.height + root.margin)
    }
    background: Rectangle {
        color: Theme.color.overlay
        radius: 4
        border.color: Qt.lighter(Theme.color.overlay)
        border.width: 1
    }
    contentItem: Text {
        padding: 4
        text: root.text
        color: Theme.color.text
        font.pixelSize: 13
    }
}