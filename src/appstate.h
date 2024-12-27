#ifndef APPSTATE_H
#define APPSTATE_H

#include <QObject>
#include <QQmlEngine>

class AppState : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(QString workspace READ getWorkspace NOTIFY workspaceChanged)

public:
    explicit AppState(QObject *parent = nullptr);
    QString getWorkspace() const;
    Q_INVOKABLE void setWorkspace(const QString &value);

signals:
    void workspaceChanged();

private:
    QString workspace = {};
};

#endif // APPSTATE_H
