#include "AppState.h"
#include "FileHandler.h"

AppState::AppState(QObject *parent): QObject{parent}
{
    
}

QString AppState::getWorkspace() const
{
    return workspace;
}

QString AppState::getCurrentNote() const
{
    return currentNote;
}

QString AppState::getEditorText() const
{
    return editorText;
}

int AppState::getEditorFontSize()
{
    return editorFontSize;
}

bool AppState::getEditorCanUndo()
{
    return editorCanUndo;
}

void AppState::setWorkspace(const QString &value)
{
    workspace = QString(value).replace("file://", "");
    emit workspaceChanged();
}

void AppState::setCurrentNote(const QString &value)
{
    if (currentNote == value)
        return;

    currentNote = value;
    emit currentNoteChanged();
}

void AppState::setEditorText(const QString &text)
{
    if (editorText == text)
        return;

    editorText = text;
    emit editorTextChanged();
}

void AppState::setEditorFontSize(int size)
{
    if (editorFontSize == size)
        return;

    editorFontSize = size;
    emit editorFontSizeChanged();
}

void AppState::setEditorCanUndo(bool value)
{
    if (editorCanUndo == value)
        return;

    editorCanUndo = value;
    emit editorCanUndoChanged();
}

void AppState::saveCurrentNote()
{
    FileHandler::saveFile(currentNote, editorText);
    emit currentNoteSaved();
}