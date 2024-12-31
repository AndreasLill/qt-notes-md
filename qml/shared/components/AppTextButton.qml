import QtQuick
import QtQuick.Controls

Button {
    required property string contentText
    required property color contentColor
    property int fontSize: 15

    signal onClicked

    id: root
    contentItem: Text {
        text: root.contentText
        color: root.hovered ? Qt.lighter(root.contentColor) : root.contentColor
        font.pixelSize: root.fontSize
        font.bold: true
    }
    background: null
    onClicked: root.onClicked
}