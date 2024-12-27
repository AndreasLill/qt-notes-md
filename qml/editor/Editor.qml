import QtQuick
import QtQuick.Controls
import qtnotesmd

Rectangle {
    id: root
    color: Theme.current.surface

    TextArea {
        color: Theme.current.text
        font.pixelSize: 15
        anchors.fill: parent
    }
}