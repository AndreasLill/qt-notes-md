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
    color: Theme.color.background
    menuBar: AppMenuBar {

        Menu {
            id: fileMenu
            title: "File"

            AppMenuItem {
                text: "Save"
                hint: "CTRL+S"
                shortcut: StandardKey.Save
                onClicked: AppState.saveCurrentNote()
            }
            AppMenuItem {
                text: "Quit"
                hint: "CTRL+Q"
                shortcut: StandardKey.Quit
                onClicked: Qt.quit()
            }
        }
    }

    WorkspacePicker {
        id: workspacePicker
        anchors.centerIn: parent
        onFolderSelected: (folder) => AppState.setWorkspace(folder)
        visible: !AppState.workspace
    }

    SideBar {
        id: sideBar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        visible: AppState.workspace
    }

    Rectangle {
        id: divider
        implicitWidth: 1
        anchors.left: sideBar.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: Qt.lighter(Theme.color.surface)
        visible: AppState.workspace
    }

    SplitView {
        id: splitView
        anchors.left: divider.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        orientation: Qt.Horizontal
        visible: AppState.workspace

        handle: RowLayout {
            id: handleRoot
            spacing: 0

            Rectangle {
                Layout.fillHeight: true
                implicitWidth: 1
                color: Theme.color.surface
            }
            Rectangle {
                Layout.fillHeight: true
                implicitWidth: 1
                color: Qt.lighter(Theme.color.surface)
            }
            Rectangle {
                Layout.fillHeight: true
                implicitWidth: 1
                color: Theme.color.editorBackground
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
