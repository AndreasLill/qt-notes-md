#include "fileviewermodel.h"

#include <QStandardPaths>

FileViewerModel::FileViewerModel(QObject *parent) : QFileSystemModel(parent)
{
    setFilter(QDir::AllEntries | QDir::Hidden | QDir::NoDotAndDotDot);
}

int FileViewerModel::columnCount(const QModelIndex &parent) const
{
    return 1;
}

QModelIndex FileViewerModel::getRootIndex() const
{
    return rootIndex;
}

void FileViewerModel::setRootIndex(const QModelIndex &index)
{
    rootIndex = index;
    emit rootIndexChanged();
}

void FileViewerModel::setRootDirectory(const QString &str)
{
    QDir dir(str);
    dir.makeAbsolute();
    setRootPath(dir.path());
    setRootIndex(QFileSystemModel::index(dir.path(), 0));
}