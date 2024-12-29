#include "workspacefilesystemmodel.h"

#include <QStandardPaths>

WorkspaceFileSystemModel::WorkspaceFileSystemModel(QObject *parent) : QFileSystemModel(parent)
{
    setFilter(QDir::AllEntries | QDir::NoDotAndDotDot);
}

int WorkspaceFileSystemModel::columnCount(const QModelIndex &parent) const
{
    return 1;
}

QVariant WorkspaceFileSystemModel::getRootIndex() const
{
    return QVariant::fromValue(rootIndex);
}

void WorkspaceFileSystemModel::setRootIndex(const QVariant &index)
{
    rootIndex = index.value<QModelIndex>();
    emit rootIndexChanged();
}

void WorkspaceFileSystemModel::setRootDirectory(const QString &str)
{
    QDir dir(str);
    dir.makeAbsolute();
    setRootPath(dir.path());
    setRootIndex(QFileSystemModel::index(dir.path(), 0));
}