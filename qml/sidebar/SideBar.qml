import QtQuick
import QtQuick.Layouts
import qtnotesmd

Rectangle {
    id: root
    width: 48
    color: "transparent"
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
                // TODO: Add new note in workspace.
                console.log("clicked add")
            }
        }

        SideBarButton {
            Layout.alignment: Qt.AlignHCenter
            tooltip: qsTr("Create Folder")
            image: "../../assets/add_folder_24dp.svg"
            imageColor: Theme.current.text
            backgroundColor: Theme.current.background
            onClicked: {
                // TODO: Add new folder in workspace.
                console.log("clicked add_folder")
            }
        }
    }
}

