import QtQuick
import QtQuick.Controls
import qtnotesmd

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    color: Theme.color.surface
    border.width: 1
    border.color: (dragItem && dragTarget == AppState.workspace) ? Theme.color.accent : "transparent"

    property string dragItem: ""
    property string dragTarget: ""

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

        function getParentFilePath(parentPath) {
            let pathIndex = parentPath.toString().lastIndexOf("/")
            return parentPath.toString().substring(0, pathIndex)
        }

        delegate: TreeViewDelegate {

            required property int index
            required property url filePath
            required property string fileName

            id: item
            indentation: 8
            implicitWidth: treeView.width
            implicitHeight: 28

            // Disable hover on item that is being dragged to prevent hover collisions.
            hoverEnabled: root.dragItem != item.filePath

            onHoveredChanged: {

                if (item.hovered) {
                    root.dragTarget = item.filePath
                }
                if (root.dragTarget == item.filePath && !item.hovered) {
                    root.dragTarget = AppState.workspace
                }
            }

            DragHandler {
                id: dragHandler
                target: parent
                onActiveChanged: {
                    if (active) {
                        root.dragItem = item.filePath
                    }
                    else
                    {
                        let success = AppState.moveFile(item.filePath, root.dragTarget, item.fileName)

                        if (success && AppState.currentNote == item.filePath) {
                            AppState.setCurrentNote(root.dragTarget + "/" + item.fileName)
                        }

                        if (!success) {
                            // Refresh model on failure to reset position of items.
                            WorkspaceFileSystemModel.refresh()
                        }

                        root.dragItem = ""
                    }
                }
            }

            TapHandler {
                id: tapHandler
                acceptedButtons: Qt.LeftButton
                onTapped: {
                    if (!root.dragItem && !item.hasChildren) {
                        AppState.setCurrentNote(item.filePath)
                    }
                }
            }
            
            contentItem: Text {
                text: (AppState.currentNote == item.filePath && AppState.editorCanUndo) ? item.fileName + "*" : item.fileName
                color: (AppState.currentNote == item.filePath) ? Theme.color.accent : Theme.color.text
                font.bold: (AppState.currentNote == item.filePath) ? true : false
            }

            background: Rectangle {
                id: itemBackground
                radius: root.dragItem ? 0 : 4
                opacity: root.dragItem ? 0.3 : 1
                color: {
                    (root.dragItem == item.filePath) ? "transparent" :
                    (root.dragItem && root.dragTarget == item.filePath) || // Folder is target, color folder
                    (root.dragItem && item.filePath == treeView.getParentFilePath(dragTarget)) || // File is target, color parent folder
                    (root.dragItem && treeView.getParentFilePath(item.filePath) == treeView.getParentFilePath(dragTarget) && treeView.getParentFilePath(item.filePath) != AppState.workspace) || // File is target, color siblings if sibling is not workspace root folder
                    (root.dragItem && treeView.getParentFilePath(item.filePath) == dragTarget && treeView.getParentFilePath(item.filePath) != AppState.workspace) ? // Folder is target, color children of folder, unless child is workspace root folder
                    Theme.color.accent : (!root.dragItem && item.hovered) ? Qt.lighter(Theme.color.surface) : "transparent"
                }
            }
        }
    }
}