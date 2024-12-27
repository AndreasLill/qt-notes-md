#include "workspaceviewmodel.h"

#include <QStandardPaths>

WorkspaceViewModel::WorkspaceViewModel(QObject *parent) : QFileSystemModel(parent)
{
    setFilter(QDir::AllEntries | QDir::Hidden | QDir::NoDotAndDotDot);
}

int WorkspaceViewModel::columnCount(const QModelIndex &parent) const
{
    return 1;
}

QModelIndex WorkspaceViewModel::getRootIndex() const
{
    return rootIndex;
}

void WorkspaceViewModel::setRootIndex(const QModelIndex &index)
{
    rootIndex = index;
    emit rootIndexChanged();
}

void WorkspaceViewModel::setRootDirectory(const QString &str)
{
    QDir dir(str);
    dir.makeAbsolute();
    setRootPath(dir.path());
    setRootIndex(QFileSystemModel::index(dir.path(), 0));
}