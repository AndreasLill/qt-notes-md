import QtQuick
import QtQuick.Controls
import qtnotesmd

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    color: Theme.color.surface
    border.width: 1
    border.color: {
        (dragItem && dragTarget == AppState.workspace) || // The target is workspace.
        (dragItem && dragTargetIsFile && dragTargetParent == AppState.workspace) ? // The target is a file and the parent is workspace.
        Theme.color.accent : "transparent"
    }

    property string contextTarget: ""
    property string dragItem: ""
    property string dragTarget: ""
    property string dragTargetParent: ""
    property bool dragTargetIsFile: false

    function getParentFilePath(parentPath) {
        const pathIndex = parentPath.lastIndexOf("/")
        return parentPath.substring(0, pathIndex)
    }

    function isFile(path) {
        const lastDotIndex = path.lastIndexOf('.');
        const lastSlashIndex = Math.max(path.lastIndexOf('/'), path.lastIndexOf('\\'));
        return lastDotIndex > lastSlashIndex
    }

    Connections {
        target: AppState
        function onWorkspaceChanged() {
            // Update the root directory when workspace changes.
            WorkspaceFileSystemModel.setRootDirectory(AppState.workspace)
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
            required property string filePath
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
                    root.dragTargetParent = root.getParentFilePath(item.filePath)
                    root.dragTargetIsFile = root.isFile(item.filePath)
                }
                if (root.dragTarget == item.filePath && !item.hovered) {
                    root.dragTarget = AppState.workspace
                    root.dragTargetParent = ""
                    root.dragTargetIsFile = false
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
                        const success = AppState.moveFile(item.filePath, root.dragTarget, item.fileName)

                        if (!success) {
                            // Refresh model on failure to reset position of items.
                            WorkspaceFileSystemModel.refresh()
                        }

                        root.dragItem = ""
                    }
                }
            }

            TapHandler {
                acceptedButtons: Qt.LeftButton
                onTapped: {
                    if (!root.dragItem && !item.hasChildren) {
                        AppState.setCurrentNote(item.filePath)
                    }
                }
            }

            TapHandler {
                acceptedButtons: Qt.RightButton
                onTapped: {
                    root.contextTarget = item.filePath
                    itemContextMenu.popup()
                }
            }

            AppMenu {
                id: itemContextMenu

                AppMenuItem {
                    text: "Delete"
                    onClicked: {
                        if (item.hasChildren)
                            AppState.deleteFolder(item.filePath)
                        else
                            AppState.deleteFile(item.filePath)
                    }
                }
            }
            
            contentItem: Text {
                text: (AppState.currentNote == item.filePath && AppState.editorIsUnsaved) ? item.fileName + "*" : item.fileName
                color: (AppState.currentNote == item.filePath) ? Theme.color.accent : Theme.color.text
                font.bold: (AppState.currentNote == item.filePath) ? true : false
            }

            background: Rectangle {
                id: itemBackground
                radius: root.dragItem ? 0 : 4
                opacity: root.dragItem ? 0.3 : 1
                color: {
                    (root.dragItem == item.filePath) ? "transparent" :
                    (root.dragItem && item.hasChildren && item.filePath == root.dragTarget) || // This item is the target folder.
                    (root.dragItem && item.hasChildren && root.dragTargetIsFile && item.filePath == root.dragTargetParent) || // This item is a folder, the target is a child.
                    (root.dragItem && !root.dragTargetIsFile && item.filePath.startsWith(root.dragTarget + "/") && root.dragTarget != AppState.workspace) || // This item is a child of the target folder.
                    (root.dragItem && root.dragTargetIsFile && item.filePath.startsWith(root.dragTargetParent + "/") && root.dragTargetParent != AppState.workspace) // This item is a child of target parent folder.
                    ? Theme.color.accent : (!root.dragItem && item.hovered) ? Qt.lighter(Theme.color.surface) : "transparent"
                }
                border.width: 1
                border.color: (itemContextMenu.opened && root.contextTarget == item.filePath) ? Theme.color.accent : "transparent"
            }
        }
    }
}