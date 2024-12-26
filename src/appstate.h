#ifndef APPSTATE_H
#define APPSTATE_H

#include <QObject>
#include <QQmlEngine>

class AppState : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(QUrl workspace READ getWorkspace NOTIFY workspaceChanged)

public:
    explicit AppState(QObject *parent = nullptr);
    QUrl getWorkspace() const;
    Q_INVOKABLE void setWorkspace(const QUrl& value);

private:
    QUrl workspace = {};

signals:
    void workspaceChanged();
};

#endif // APPSTATE_H
