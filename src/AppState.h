#pragma once

#include <QObject>
#include <QQmlEngine>

class AppState : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(QString workspace READ getWorkspace NOTIFY workspaceChanged)
    Q_PROPERTY(QString currentNote READ getCurrentNote NOTIFY currentNoteChanged)
    Q_PROPERTY(QString editorText READ getEditorText NOTIFY editorTextChanged)
    Q_PROPERTY(int editorFontSize READ getEditorFontSize NOTIFY editorFontSizeChanged)
    Q_PROPERTY(bool editorIsUnsaved READ getEditorIsUnsaved NOTIFY editorIsUnsavedChanged)

public:
    explicit AppState(QObject *parent = nullptr) : QObject(parent) {}

    QString getWorkspace() const;
    QString getCurrentNote() const;
    QString getEditorText() const;
    int getEditorFontSize();
    bool getEditorIsUnsaved();

    Q_INVOKABLE void loadStateFromFile();
    Q_INVOKABLE void saveStateToFile();
    Q_INVOKABLE void saveCurrentNote();
    Q_INVOKABLE void setWorkspace(const QString &value);
    Q_INVOKABLE void setCurrentNote(const QString &value);
    Q_INVOKABLE void setEditorText(const QString &text);
    Q_INVOKABLE void setEditorFontSize(int size);
    Q_INVOKABLE void setEditorIsUnsaved(bool value);
    Q_INVOKABLE void createFile(const QString &path, const QString &name);
    Q_INVOKABLE void createFolder(const QString &path, const QString &name);
    Q_INVOKABLE bool moveFile(const QString &fromPath, const QString &toPath, const QString &fileName);
    Q_INVOKABLE void deleteFile(const QString &path);
    Q_INVOKABLE void deleteFolder(const QString &path);

signals:
    void workspaceChanged();
    void currentNoteChanged();
    void currentNoteSaved();
    void editorFontSizeChanged();
    void editorIsUnsavedChanged();
    void editorTextChanged();

private:
    QString m_workspace;
    QString m_currentNote;
    QString m_editorText;
    bool m_editorIsUnsaved = false;
    int m_editorFontSize = 15;
};