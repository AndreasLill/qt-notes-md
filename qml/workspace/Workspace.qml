import QtQuick
import QtQuick.Controls
import qtnotesmd

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    color: Theme.background

    Connections {
        target: AppState
        function onWorkspaceChanged() {
            // Update the root directory when workspace changes.
            FileViewerModel.setRootDirectory(AppState.workspace)
        }
    }

    TreeView {
        id: treeView
        anchors.fill: parent
        model: FileViewerModel
        rootIndex: FileViewerModel.rootIndex
        boundsBehavior: Flickable.StopAtBounds
        boundsMovement: Flickable.StopAtBounds

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
                color: Theme.text
            }

            background: Rectangle {
                color: Theme.background
            }
        }
    }
}