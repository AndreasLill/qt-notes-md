import QtQuick
import QtQuick.Layouts
import qtnotesmd

Rectangle {
    id: root
    width: 48
    color: Theme.color.surface

    ColumnLayout {
        id: columnLayout
        spacing: 8
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 8
        anchors.bottomMargin: 8

        AppIconButton {
            id: createNoteButton
            Layout.alignment: Qt.AlignHCenter
            image: "../assets/add_24dp.svg"
            size: 20
            onClicked: {
                let filePath = AppState.createFile(AppState.workspace, "Untitled Note")
                AppState.setCurrentNote(filePath)
                console.log("Created folder: " + filePath)
            }

            AppToolTip {
                visible: createNoteButton.hovered
                text: "Create Note"
            }
        }

        AppIconButton {
            id: createFolderButton
            Layout.alignment: Qt.AlignHCenter
            image: "../assets/add_folder_24dp.svg"
            size: 20
            onClicked: {
                let folderPath = AppState.createFolder(AppState.workspace, "Untitled Folder")
                console.log("Created folder: " + folderPath)
            }

            AppToolTip {
                visible: createFolderButton.hovered
                text: "Create Folder"
            }
        }
    }
}

