import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import qtnotesmd

ColumnLayout {
    id: root
    spacing: 8

    signal folderSelected(var folder)

    Text {
        text: qsTr("No workspace folder is selected.")
        color: Theme.text
        font.pixelSize: 15
        Layout.alignment: Qt.AlignCenter
    }

    Button {
        text: qsTr("Select Workspace")
        Layout.alignment: Qt.AlignCenter
        padding: 8
        onClicked: folderDialog.open()
    }

    FolderDialog {
        id: folderDialog
        currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
        onAccepted: root.folderSelected(selectedFolder)
    }
}