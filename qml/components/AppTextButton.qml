import QtQuick
import QtQuick.Controls
import qtnotesmd

Button {
    property color color: Theme.color.accent

    id: root
    padding: 8
    contentItem: Text {
        horizontalAlignment: Text.AlignHCenter
        text: root.text
        color: root.color
        font.pixelSize: 15
        font.bold: true
    }
    background: Rectangle {
        color: root.hovered ? root.color : "transparent"
        radius: 4
        opacity: 0.1
    }
}