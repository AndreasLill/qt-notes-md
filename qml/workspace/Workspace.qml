import QtQuick
import QtQuick.Controls
import qtnotesmd

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    color: Theme.current.background

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
                text: item.fileName
                color: Theme.current.text
            }

            background: Rectangle {
                color: (AppState.currentNote == item.filePath) ? Theme.colorWithAlpha(Theme.current.accent, 0.5) : Theme.current.transparent
            }

            HoverHandler {
                id: hoverHandler
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