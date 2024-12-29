import QtQuick
import QtQuick.Controls
import qtnotesmd

Rectangle {
    id: root
    color: Theme.current.surface

    property string editorText;

    Connections {
        target: AppState
        function onCurrentNoteChanged() {
            // Update the editor with the current note.
            root.editorText = FileHandler.readFile(AppState.currentNote)
            console.log("current note set to " + AppState.currentNote)
        }
    }

    TextArea {
        color: Theme.current.text
        font.pixelSize: 15
        anchors.fill: parent
        text: root.editorText
    }
}