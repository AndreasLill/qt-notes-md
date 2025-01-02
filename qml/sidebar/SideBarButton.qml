import QtQuick
import QtQuick.Controls

Button {
    id: root
    required property string tooltip
    required property string image

    implicitWidth: 32
    implicitHeight: 32
    icon.width: 20
    icon.height: 20
    icon.source: root.image
    icon.color: palette.buttonText
    background: Rectangle {
        radius: 4
        color: root.hovered ? Qt.lighter(palette.base) : "transparent"
    }

    ToolTip {
        visible: root.hovered
        x: Math.round(root.width + 8)
        y: Math.round((root.height - height) / 2)
        text: root.tooltip
        font.pixelSize: 13
        background: Rectangle {
            color: palette.toolTipBase
            radius: 4
        }
    }
}