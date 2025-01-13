import QtQuick
import QtQuick.Controls
import qtnotesmd

pragma ComponentBehavior: Bound

Rectangle {
    id: root

    AppConfirmDialog {
        id: deleteDialog
        title: "Delete?"
        text: "Are you sure you want to delete <b>" + workspace.contextMenuTargetName + "</b>?"
        acceptButtonText: "Delete"

        onClickAccept: {
            if (workspace.contextMenuTargetIsFile)
                AppState.deleteFile(workspace.contextMenuTarget)
            else
                AppState.deleteFolder(workspace.contextMenuTarget)
        }
    }

    SideBar {
        id: sideBar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
    } 

    Rectangle {
        id: divider
        width: 1
        anchors.left: sideBar.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: Qt.lighter(Theme.color.surface)
        visible: AppState.workspace
    }

    Rectangle {
        property string contextMenuTarget: ""
        property string contextMenuTargetName: ""
        property bool contextMenuTargetIsFile: false
        property string dragItem: ""
        property string dragTarget: ""
        property string dragTargetParent: ""
        property bool dragTargetIsFile: false

        id: workspace
        color: Theme.color.surface
        anchors.left: divider.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        border.width: 1
        border.color: {
            (dragItem && dragTarget == AppState.workspace) || // The target is workspace.
            (dragItem && dragTargetIsFile && dragTargetParent == AppState.workspace) ? // The target is a file and the parent is workspace.
            Theme.color.accent : "transparent"
        }


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

        Rectangle {
            property string text

            id: dragDisplay
            color: Theme.color.overlay
            width: dragText.implicitWidth
            height: dragText.implicitHeight
            visible: workspace.dragItem
            radius: 4
            z: 99

            Text {
                id: dragText
                anchors.centerIn: parent
                text: dragDisplay.text
                color: Theme.color.text
                padding: 8
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
                z: (workspace.dragItem == item.filePath) ? 99 : 0

                // Disable hover on item that is being dragged to prevent hover collisions.
                hoverEnabled: workspace.dragItem != item.filePath

                onHoveredChanged: {

                    if (item.hovered) {
                        workspace.dragTarget = item.filePath
                        workspace.dragTargetParent = workspace.getParentFilePath(item.filePath)
                        workspace.dragTargetIsFile = workspace.isFile(item.filePath)
                    }
                    if (workspace.dragTarget == item.filePath && !item.hovered) {
                        workspace.dragTarget = AppState.workspace
                        workspace.dragTargetParent = ""
                        workspace.dragTargetIsFile = false
                    }
                }

                MouseArea {
                    id: mouseArea
                    
                }

                DragHandler {
                    id: dragHandler
                    // Set target to null in handler and instead update the position manually on "dragDisplay" when translation changes.
                    target: null
                    onTranslationChanged: {
                        const heightOffset = item.height * item.index
                        const offset = 16

                        dragDisplay.x = dragHandler.centroid.position.x + offset
                        dragDisplay.y = dragHandler.centroid.position.y + heightOffset + offset
                    }
                    onActiveChanged: {
                        if (active) {
                            dragDisplay.text = item.fileName
                            workspace.dragItem = item.filePath
                        }
                        else
                        {
                            const success = AppState.moveFile(item.filePath, workspace.dragTarget, item.fileName)

                            if (!success) {
                                // Refresh model on failure to reset position of items.
                                WorkspaceFileSystemModel.refresh()
                            }

                            workspace.dragItem = ""
                        }
                    }
                }

                TapHandler {
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        if (!workspace.dragItem && !item.hasChildren) {
                            AppState.setCurrentNote(item.filePath)
                        }
                    }
                }

                TapHandler {
                    acceptedButtons: Qt.RightButton
                    onTapped: {
                        workspace.contextMenuTarget = item.filePath
                        workspace.contextMenuTargetName = item.fileName
                        workspace.contextMenuTargetIsFile = !item.hasChildren
                        itemContextMenu.popup()
                    }
                }

                AppMenu {
                    id: itemContextMenu

                    AppMenuItem {
                        text: "Delete"
                        onClicked: {
                            deleteDialog.open()
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
                    radius: workspace.dragItem ? 0 : 4
                    opacity: workspace.dragItem ? 0.3 : 1
                    color: {
                        (workspace.dragItem == item.filePath) ? "transparent" :
                        (workspace.dragItem && item.hasChildren && item.filePath == workspace.dragTarget) || // This item is the target folder.
                        (workspace.dragItem && item.hasChildren && workspace.dragTargetIsFile && item.filePath == workspace.dragTargetParent) || // This item is a folder, the target is a child.
                        (workspace.dragItem && !workspace.dragTargetIsFile && item.filePath.startsWith(workspace.dragTarget + "/") && workspace.dragTarget != AppState.workspace) || // This item is a child of the target folder.
                        (workspace.dragItem && workspace.dragTargetIsFile && item.filePath.startsWith(workspace.dragTargetParent + "/") && workspace.dragTargetParent != AppState.workspace) // This item is a child of target parent folder.
                        ? Theme.color.accent : (!workspace.dragItem && item.hovered) ? Qt.lighter(Theme.color.surface) : "transparent"
                    }
                    border.width: 1
                    border.color: (itemContextMenu.opened && workspace.contextMenuTarget == item.filePath) ? Theme.color.accent : "transparent"
                }
            }
        }
    }
}