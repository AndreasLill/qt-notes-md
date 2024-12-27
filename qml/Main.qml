import QtQuick
import QtQuick.Controls
import qtnotesmd

ApplicationWindow {
    id: root
    width: 1280
    height: 720
    visible: true
    title: qsTr("QT Notes MD")
    color: Theme.current.background

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
