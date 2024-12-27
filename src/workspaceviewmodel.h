#ifndef WORKSPACEVIEWMODEL_H
#define WORKSPACEVIEWMODEL_H

#include <QFileSystemModel>
#include <QQmlEngine>

class WorkspaceViewModel : public QFileSystemModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    // Supposed to be the type: QModelIndex
    // But get error in QML: Type "QModelIndex" of property "rootIndex" not found. This is likely due to a missing dependency entry or a type not being exposed declaratively.
    Q_PROPERTY(QVariant rootIndex READ getRootIndex WRITE setRootIndex NOTIFY rootIndexChanged)

public:
    explicit WorkspaceViewModel(QObject *parent = nullptr);
    int columnCount(const QModelIndex &parent) const override;
    QVariant getRootIndex() const;
    void setRootIndex(const QVariant &index);

    Q_INVOKABLE void setRootDirectory(const QString &str);

signals:
    void rootIndexChanged();

private:
    QModelIndex rootIndex;
};

#endif