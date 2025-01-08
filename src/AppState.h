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
    Q_PROPERTY(bool editorCanUndo READ getEditorCanUndo NOTIFY editorCanUndoChanged)

public:
    explicit AppState(QObject *parent = nullptr) : QObject(parent) {}

    QString getWorkspace() const;
    QString getCurrentNote() const;
    QString getEditorText() const;
    int getEditorFontSize();
    bool getEditorCanUndo();

    Q_INVOKABLE void loadStateFromFile();
    Q_INVOKABLE void saveStateToFile();
    Q_INVOKABLE void setWorkspace(const QString &value);
    Q_INVOKABLE void setCurrentNote(const QString &value);
    Q_INVOKABLE void setEditorText(const QString &text);
    Q_INVOKABLE void setEditorFontSize(int size);
    Q_INVOKABLE void setEditorCanUndo(bool value);
    Q_INVOKABLE void saveCurrentNote();
    Q_INVOKABLE QString createFile(const QString &path, const QString &name);
    Q_INVOKABLE QString createFolder(const QString &path, const QString &name);
    Q_INVOKABLE bool moveFile(const QString &fromPath, const QString &toPath, const QString &fileName);

signals:
    void workspaceChanged();
    void currentNoteChanged();
    void currentNoteSaved();
    void editorFontSizeChanged();
    void editorCanUndoChanged();
    void editorTextChanged();

private:
    static const QString APP_CONFIG_ROOT_PATH;
    static const QString APP_CONFIG_FOLDER_NAME;
    static const QString APP_CONFIG_FILE_NAME;
    static const QString APP_CONFIG_FULL_PATH;

    QString workspace;
    QString currentNote;
    QString editorText;
    bool editorCanUndo = false;
    int editorFontSize = 15;
};