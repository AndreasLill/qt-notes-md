import QtQuick
import QtQuick.Controls
import qtnotesmd

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    color: Theme.color.surface

    Connections {
        target: AppState
        function onWorkspaceChanged() {
            // Update the root directory when workspace changes.
            WorkspaceFileSystemModel.setRootDirectory(AppState.workspace)
            console.log("Workspace set to " + AppState.workspace)
        }
    }

    TreeView {
        id: treeView
        anchors.fill: parent
        anchors.margins: 4
        model: WorkspaceFileSystemModel
        rootIndex: WorkspaceFileSystemModel.rootIndex
        boundsBehavior: Flickable.StopAtBounds
        boundsMovement: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar {
            id: scrollBar
        }

        delegate: TreeViewDelegate {

            required property int index
            required property url filePath
            required property string fileName

            id: item
            indentation: 8
            implicitWidth: treeView.width
            implicitHeight: 25
            
            contentItem: Text {
                text: (AppState.currentNote == item.filePath && AppState.editorCanUndo) ? item.fileName + "*" : item.fileName
                color: Theme.color.text
            }

            background: Rectangle {
                color: (AppState.currentNote == item.filePath) ? Theme.color.accent : (item.hovered) ? Qt.lighter(Theme.color.surface) : "transparent"
                radius: 4
                opacity: (AppState.currentNote == item.filePath) ? 0.5 : 1
            }

            TapHandler {
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onSingleTapped: (eventPoint, button) => {
                    switch (button) {
                        case Qt.LeftButton:
                            if (!item.hasChildren) {
                                AppState.setCurrentNote(item.filePath)
                            }
                            break;
                        case Qt.RightButton:
                            break;
                    }
                }
            }
        }
    }
}