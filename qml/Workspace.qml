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
                color:  (!root.dragItem && item.hovered) ? Qt.lighter(Theme.color.surface) : "transparent"
                radius: 4
                border.width: 1
                border.color: (root.dragItem && root.dragTarget == item.filePath) ? Theme.color.accent : "transparent"
            }
        }
    }
}