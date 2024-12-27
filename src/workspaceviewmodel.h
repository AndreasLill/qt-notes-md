#ifndef WORKSPACEVIEWMODEL_H
#define WORKSPACEVIEWMODEL_H

#include <QFileSystemModel>
#include <QQmlEngine>

class WorkspaceViewModel : public QFileSystemModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(QModelIndex rootIndex READ getRootIndex WRITE setRootIndex NOTIFY rootIndexChanged)

public:
    explicit WorkspaceViewModel(QObject *parent = nullptr);
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