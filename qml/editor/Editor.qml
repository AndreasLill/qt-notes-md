import QtQuick
import QtQuick.Controls
import qtnotesmd

Rectangle {
    required property AppState appState

    id: root
    color: "transparent"

    TextArea {
        color: "#FFF"
        font.pixelSize: 15
        anchors.fill: parent
    }
}