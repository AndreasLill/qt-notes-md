import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Dialogs
import qtnotesmd

ColumnLayout {
    id: root
    spacing: 16

    signal folderSelected(var folder)

    Text {
        text: qsTr("No workspace folder is selected.")
        color: palette.windowText
        font.pixelSize: 16
        Layout.alignment: Qt.AlignHCenter
    }

    AppTextButton {
        Layout.alignment: Qt.AlignHCenter
        contentText: qsTr("Select Workspace")
        onClicked: folderDialog.open()
    }

    FolderDialog {
        id: folderDialog
        currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
        onAccepted: root.folderSelected(selectedFolder)
    }
}