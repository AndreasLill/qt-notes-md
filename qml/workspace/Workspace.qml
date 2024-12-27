import QtQuick
import qtnotesmd

Rectangle {
    id: root
    color: Theme.transparent

    WorkspaceFileViewer {
        id: fileViewer
        anchors.fill: parent
    }
}