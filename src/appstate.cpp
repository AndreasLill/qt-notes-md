#include "appstate.h"

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