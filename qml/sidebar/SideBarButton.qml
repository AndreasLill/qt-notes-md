import QtQuick
import QtQuick.Controls

Button {
    id: root
    required property string image
    required property color imageColor
    required property color backgroundColor
    signal onClicked

    implicitWidth: 32
    implicitHeight: 32
    icon.width: 24
    icon.height: 24
    icon.source: root.image
    icon.color: root.pressed ? Qt.lighter(root.imageColor) : root.imageColor
    background: Rectangle {
        radius: 4
        color: root.hovered ? Qt.lighter(root.backgroundColor) : root.backgroundColor
    }
    onClicked: root.onClicked
}