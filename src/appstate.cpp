#include "appstate.h"

AppState::AppState(QObject *parent)
    : QObject{parent}
{}

QString AppState::getWorkspace() const
{
    return workspace;
}

void AppState::setWorkspace(const QString &value)
{
    workspace = QString(value).replace("file://", "");
    emit workspaceChanged();
}