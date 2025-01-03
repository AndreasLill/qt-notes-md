import QtQuick
import QtQuick.Controls
import qtnotesmd

Button {
    required property string contentText
    property int fontSize: 15

    id: root
    padding: 8
    contentItem: Text {
        text: root.contentText
        color: Theme.color.accent
        font.pixelSize: root.fontSize
        font.bold: true
    }
    background: Rectangle {
        color: root.hovered ? Theme.color.accent : "transparent"
        radius: 4
        opacity: 0.1
    }
}