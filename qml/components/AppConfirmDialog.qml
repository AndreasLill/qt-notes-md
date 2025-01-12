import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qtnotesmd

Dialog {
    property string acceptButtonText: "OK"
    property string cancelButtonText: "Cancel"
    property string text: ""

    id: root
    x: (Overlay.overlay.width - width) / 2
    y: (Overlay.overlay.height - height) / 2
    z: 999
    padding: 16
    modal: true

    signal clickAccept
    signal clickCancel

    Overlay.modal: Rectangle {
        color: "black"
        opacity: 0.4
    }

    header: Rectangle {}
    footer: Rectangle {}

    background: Rectangle {
        color: Theme.color.surface
        radius: 4
        border.width: 1
        border.color: Theme.color.text
    }

    contentItem: ColumnLayout {
        spacing: 16

        Text {
            Layout.maximumWidth: 360
            text: root.title
            color: Theme.color.text
            font.pixelSize: 16
            font.bold: true
            wrapMode: Text.WordWrap
        }

        Text {
            Layout.maximumWidth: 360
            text: root.text
            color: Theme.color.text
            lineHeight: 1.25
            font.pixelSize: 15
            wrapMode: Text.WordWrap
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight

            AppTextButton {
                id: buttonOk
                color: Theme.color.alert
                implicitWidth: 100
                text: root.acceptButtonText
                onClicked: {
                    root.clickAccept()
                    root.close()
                }
            }

            AppTextButton {
                id: buttonCancel
                implicitWidth: 100
                text: root.cancelButtonText
                onClicked: {
                    root.clickCancel()
                    root.close()
                }
            }
        }
    }
}