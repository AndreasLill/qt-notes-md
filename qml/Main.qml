import QtQuick
import QtQuick.Controls
import qtnotesmd

Window {
    AppState {
        id: appState
    }
    
    id: root
    width: 1280
    height: 720
    visible: true
    title: qsTr("Hello World")
    color: "#222"

    WorkspacePicker {
        id: workspacePicker
        visible: appState.workspace == ""
        anchors.centerIn: parent
        onFolderSelected: (folder) => appState.setWorkspace(folder)
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        visible: appState.workspace != ""

        Workspace {
            appState: appState

            id: workspace
            implicitWidth: 300
            SplitView.minimumWidth: 200
        }

        Editor {
            appState: appState

            id: editor
        }
    }
}
