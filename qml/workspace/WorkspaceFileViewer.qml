import QtQuick
import QtQuick.Controls
import qtnotesmd

pragma ComponentBehavior: Bound

TreeView {
    id: root
    anchors.fill: parent
    model: FileViewerModel
    rootIndex: FileViewerModel.rootIndex
    boundsBehavior: Flickable.StopAtBounds
    boundsMovement: Flickable.StopAtBounds

    delegate: TreeViewDelegate {
        id: item
        indentation: 8
        implicitWidth: root.width
        implicitHeight: 25

        required property int index
        required property url filePath
        required property string fileName
        
        contentItem: Text {
            text: item.fileName
            color: Theme.text
        }
    }
}