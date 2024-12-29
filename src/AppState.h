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
    Q_PROPERTY(QString currentNote READ getCurrentNote NOTIFY currentNoteChanged)

public:
    explicit AppState(QObject *parent = nullptr);
    QString getWorkspace() const;
    QString getCurrentNote() const;
    Q_INVOKABLE void setWorkspace(const QString &value);
    Q_INVOKABLE void setCurrentNote(const QString &value);

signals:
    void workspaceChanged();
    void currentNoteChanged();

private:
    QString workspace = {};
    QString currentNote = {};
};

#endif
