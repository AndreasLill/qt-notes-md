import QtQuick
import QtQuick.Controls
import qtnotesmd

Rectangle {
    id: root
    color: Theme.surface

    TextArea {
        color: Theme.text
        font.pixelSize: 15
        anchors.fill: parent
    }
}