import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qtnotesmd

ApplicationWindow {
    id: root
    width: 1280
    height: 720
    visible: true
    title: qsTr("QT Notes MD")
    color: Theme.current.background
    menuBar: AppMenuBar {
        onFileQuit: Qt.quit()
        onFileSave: AppState.saveCurrentNote()
    }

    WorkspacePicker {
        id: workspacePicker
        visible: AppState.workspace == ""
        anchors.centerIn: parent
        onFolderSelected: (folder) => AppState.setWorkspace(folder)
    }

    SideBar {
        id: sideBar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        visible: AppState.workspace != ""
    }

    DividerVertical {
        id: divider
        anchors.left: sideBar.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        visible: AppState.workspace != ""
    }

    SplitView {
        id: splitView
        anchors.left: divider.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        orientation: Qt.Horizontal
        visible: AppState.workspace != ""

        handle: RowLayout {
            id: handleRoot
            spacing: 0

            DividerVertical {
                Layout.fillHeight: true
                color: Theme.current.background
            }
            DividerVertical {
                Layout.fillHeight: true
            }
            DividerVertical {
                Layout.fillHeight: true
                color: Theme.current.surface
            }
        }

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
