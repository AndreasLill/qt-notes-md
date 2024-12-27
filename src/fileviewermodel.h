#ifndef FILEVIEWERMODEL_H
#define FILEVIEWERMODEL_H

#include <QFileSystemModel>
#include <QQmlEngine>

class FileViewerModel : public QFileSystemModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(QModelIndex rootIndex READ getRootIndex WRITE setRootIndex NOTIFY rootIndexChanged)

public:
    explicit FileViewerModel(QObject *parent = nullptr);
    int columnCount(const QModelIndex &parent) const override;
    QModelIndex getRootIndex() const;
    void setRootIndex(const QModelIndex &index);

    Q_INVOKABLE void setRootDirectory(const QString &str);

signals:
    void rootIndexChanged();

private:
    QModelIndex rootIndex;
};

#endif