import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qtnotesmd

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    color: palette.base

    onWidthChanged: textArea.update()
    onHeightChanged: textArea.update()

    Connections {
        target: AppState
        function onCurrentNoteChanged() {
            let data = AppState.readFile(AppState.currentNote)
            AppState.setEditorText(data)
            console.log("current note set to " + AppState.currentNote)
        }
        function onEditorTextChanged() {
            if (textArea.text != AppState.editorText) {
                textArea.text = AppState.editorText
            }
        }
        function onCurrentNoteSaved() {
            // Reset the undo stack by recreating the text.
            let tempText = AppState.editorText
            let tempPosition = textArea.cursorPosition
            AppState.setEditorText("")
            AppState.setEditorText(tempText)
            textArea.cursorPosition = tempPosition
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
            color: palette.windowText
            font.pixelSize: 24
        }

        AppTextButton {
            Layout.alignment: Qt.AlignHCenter
            contentText: "Create a new note"
            onClicked: {
                let fileName = AppState.createFile(AppState.workspace, "Untitled Note")
                AppState.setCurrentNote(fileName)
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
            padding: 16
            color: palette.windowText
            font.pixelSize: AppState.editorFontSize
            textFormat: TextEdit.PlainText
            // TODO: Wrap lags out when dragging split view.
            // Maybe disable on start drag and enable on end drag?
            wrapMode: TextEdit.Wrap
            tabStopDistance: fontMetrics.averageCharacterWidth * 4

            FontMetrics {
                id: fontMetrics
                font: textArea.font
            }

            onCanUndoChanged: AppState.setEditorCanUndo(textArea.canUndo)
            onTextChanged: AppState.setEditorText(textArea.text)
        }
    }
}