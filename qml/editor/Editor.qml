import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qtnotesmd

pragma ComponentBehavior: Bound

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

    Flickable {
        id: flickable
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar {
            id: scrollBar
            contentItem: Rectangle {
                implicitWidth: 10
                color: Theme.current.accent
                opacity: scrollBar.active ? 1.0 : 0.0
                Behavior on opacity {
                    OpacityAnimator {
                        duration: 500
                    }
                }
            }
        }

        TextArea.flickable: TextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme.current.text
            font.pixelSize: AppState.editorFontSize
            text: root.editorText
            textFormat: TextEdit.PlainText
            wrapMode: TextEdit.Wrap
            tabStopDistance: fontMetrics.averageCharacterWidth * 2

            cursorDelegate: Rectangle {
                visible: textArea.cursorVisible
                color: Theme.current.accent
                width: textArea.cursorRectangle.width
            }

            FontMetrics {
                id: fontMetrics
                font: textArea.font
            }
        }
    }
}