import QtQuick
import QtQuick.Controls

Button {
    required property string contentText
    property int fontSize: 15

    signal onClicked

    id: root
    padding: 6
    contentItem: Text {
        text: root.contentText
        color: palette.buttonText
        font.pixelSize: root.fontSize
        font.bold: true
    }
    background: Rectangle {
        color: root.hovered ? Qt.lighter(palette.base) : "transparent"
        radius: 4
    }
    onClicked: root.onClicked
}