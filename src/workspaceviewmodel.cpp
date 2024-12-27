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

QVariant WorkspaceViewModel::getRootIndex() const
{
    return QVariant::fromValue(rootIndex);
}

void WorkspaceViewModel::setRootIndex(const QVariant &index)
{
    rootIndex = index.value<QModelIndex>();
    emit rootIndexChanged();
}

void WorkspaceViewModel::setRootDirectory(const QString &str)
{
    QDir dir(str);
    dir.makeAbsolute();
    setRootPath(dir.path());
    setRootIndex(QFileSystemModel::index(dir.path(), 0));
}