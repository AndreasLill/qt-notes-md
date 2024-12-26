import QtQuick
import QtQuick.Controls
import qtnotesmd

Window {
    id: root
    width: 1280
    height: 720
    visible: true
    title: qsTr("Hello World")
    color: "#222"

    WorkspacePicker {
        id: workspacePicker
        visible: AppState.workspace == ""
        anchors.centerIn: parent
        onFolderSelected: (folder) => AppState.setWorkspace(folder)
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        visible: AppState.workspace != ""

        Workspace {
            id: workspace
            implicitWidth: 300
            SplitView.minimumWidth: 200
        }

        Editor {
            id: editor
        }
    }
}
