import QtQuick
import QtQuick.Layouts
import qtnotesmd

Rectangle {
    id: root
    width: 48
    color: Theme.current.transparent
    anchors.topMargin: 8
    anchors.bottomMargin: 8

    ColumnLayout {
        id: columnLayout
        spacing: 8
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        SideBarButton {
            Layout.alignment: Qt.AlignHCenter
            tooltip: qsTr("Create Note")
            image: "../../assets/add_24dp.svg"
            imageColor: Theme.current.text
            backgroundColor: Theme.current.background
            onClicked: {
                let filePath = AppState.createFile(AppState.workspace, "Untitled Note")
                AppState.setCurrentNote(filePath)
                console.log("Created folder: " + filePath)
            }
        }

        SideBarButton {
            Layout.alignment: Qt.AlignHCenter
            tooltip: qsTr("Create Folder")
            image: "../../assets/add_folder_24dp.svg"
            imageColor: Theme.current.text
            backgroundColor: Theme.current.background
            onClicked: {
                let folderPath = AppState.createFolder(AppState.workspace, "Untitled Folder")
                console.log("Created folder: " + folderPath)
            }
        }
    }
}

