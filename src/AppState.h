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
    Q_PROPERTY(int editorFontSize READ getEditorFontSize NOTIFY editorFontSizeChanged)

public:
    explicit AppState(QObject *parent = nullptr);
    QString getWorkspace() const;
    QString getCurrentNote() const;
    int getEditorFontSize();
    Q_INVOKABLE void setWorkspace(const QString &value);
    Q_INVOKABLE void setCurrentNote(const QString &value);

signals:
    void workspaceChanged();
    void currentNoteChanged();
    void editorFontSizeChanged();

private:
    QString workspace = {};
    QString currentNote = {};
    int editorFontSize = 16;
};

#endif
