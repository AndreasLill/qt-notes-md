import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qtnotesmd

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    color: Theme.current.surface

    property string editorText;

    onWidthChanged: textArea.update()
    onHeightChanged: textArea.update()

    Connections {
        target: AppState
        function onCurrentNoteChanged() {
            root.editorText = FileHandler.readFile(AppState.currentNote)
            console.log("current note set to " + AppState.currentNote)
        }
    }

    ColumnLayout {
        id: emptyLayout
        anchors.centerIn: parent
        visible: AppState.currentNote == ""
        spacing: 16

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "No note is open"
            color: Theme.current.text
            font.pixelSize: 24
        }

        AppTextButton {
            Layout.alignment: Qt.AlignHCenter
            contentText: "Create a new note"
            contentColor: Theme.current.accent
            onClicked: {
                AppState.setCurrentNote(FileHandler.createFile(AppState.workspace, "Untitled Note"))
            }
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        visible: AppState.currentNote != ""

        ScrollBar.vertical: ScrollBar {
            id: scrollBar
        }

        TextArea.flickable: TextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme.current.text
            font.pixelSize: AppState.editorFontSize
            text: root.editorText
            textFormat: TextEdit.PlainText
            // TODO: Wrap lags out when dragging split view.
            // Maybe disable on start drag and enable on end drag?
            wrapMode: TextEdit.Wrap
            tabStopDistance: fontMetrics.averageCharacterWidth * 4

            cursorDelegate: Rectangle {
                visible: textArea.cursorVisible
                color: Theme.current.accent
                width: textArea.cursorRectangle.width
            }

            FontMetrics {
                id: fontMetrics
                font: textArea.font
            }

            onCanUndoChanged: {
                AppState.setEditorCanUndo(textArea.canUndo)
            }
        }
    }
}