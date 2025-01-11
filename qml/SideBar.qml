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
            hoverColor: Qt.lighter(Theme.color.surface)
            onClicked: {
                AppState.createFile(AppState.workspace, "Untitled Note")
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
            hoverColor: Qt.lighter(Theme.color.surface)
            onClicked: {
                AppState.createFolder(AppState.workspace, "Untitled Folder")
            }

            AppToolTip {
                visible: createFolderButton.hovered
                text: "Create Folder"
            }
        }
    }
}

