#include "appstate.h"

AppState::AppState(QObject *parent)
    : QObject{parent}
{}

QUrl AppState::getWorkspace() const
{
    return workspace;
}

void AppState::setWorkspace(const QUrl& value)
{
    workspace = value;
    emit workspaceChanged();
}