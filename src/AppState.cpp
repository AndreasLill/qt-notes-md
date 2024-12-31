#include "AppState.h"

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
    currentNote = value;
    emit currentNoteChanged();
}

void AppState::setEditorCanUndo(bool value)
{
    editorCanUndo = value;
    emit editorCanUndoChanged();
}