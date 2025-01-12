#include "AppState.h"
#include "AppConfig.h"
#include "FileHandler.h"

#include <QJsonObject>

void AppState::loadStateFromFile()
{
    QJsonObject json = AppConfig::loadStateFromFile();
    setWorkspace(json["workspace"].toString());
    setCurrentNote(json["currentNote"].toString());
}

void AppState::saveStateToFile()
{
    QJsonObject json;
    json["workspace"] = m_workspace;
    json["currentNote"] = m_currentNote;
    AppConfig::saveStateToFile(json);
}

QString AppState::getWorkspace() const
{
    return m_workspace;
}

QString AppState::getCurrentNote() const
{
    return m_currentNote;
}

QString AppState::getEditorText() const
{
    return m_editorText;
}

int AppState::getEditorFontSize()
{
    return m_editorFontSize;
}

bool AppState::getEditorIsUnsaved()
{
    return m_editorIsUnsaved;
}

void AppState::setWorkspace(const QString &path)
{
    if (path.isEmpty())
        return;

    m_workspace = QString(path).replace("file://", "");
    emit workspaceChanged();
    qDebug() << "Workspace set to" << m_workspace;
}

void AppState::setCurrentNote(const QString &path)
{
    if (m_currentNote == path)
        return;

    m_currentNote = path;

    if (!path.isEmpty())
    {
        QString data = FileHandler::readFile(m_currentNote);
        setEditorText(data);
    }
    
    emit currentNoteChanged();
}

void AppState::setEditorText(const QString &text)
{
    if (m_editorText == text)
        return;

    m_editorText = text;
    emit editorTextChanged();
}

void AppState::setEditorFontSize(int size)
{
    if (m_editorFontSize == size)
        return;

    m_editorFontSize = size;
    emit editorFontSizeChanged();
}

void AppState::setEditorIsUnsaved(bool value)
{
    if (m_editorIsUnsaved == value)
        return;

    m_editorIsUnsaved = value;
    emit editorIsUnsavedChanged();
}

void AppState::saveCurrentNote()
{
    FileHandler::saveFile(m_currentNote, m_editorText);
    emit currentNoteSaved();
}

void AppState::createFile(const QString &path, const QString &name)
{
    QString filePath = FileHandler::createFileIncremental(path, name, ".md");

    if (filePath.isEmpty())
        return;

    setCurrentNote(filePath);
}

void AppState::createFolder(const QString &path, const QString &name)
{
    FileHandler::createFolderIncremental(path, name);
}

bool AppState::moveFile(const QString &fromPath, const QString &toPath, const QString &fileName)
{
    QString movedToPath = FileHandler::moveFile(fromPath, toPath, fileName);

    if (movedToPath.isEmpty())
        return false;
    if (m_currentNote != fromPath)
        return true;

    m_currentNote = movedToPath;
    emit currentNoteChanged();
    return true;
}

void AppState::deleteFile(const QString &path)
{
    if (path.isEmpty())
        return;
    
    FileHandler::deleteFile(path);

    if (!FileHandler::exists(m_currentNote))
        setCurrentNote("");
}

void AppState::deleteFolder(const QString &path)
{
    if (path.isEmpty())
        return;

    FileHandler::deleteFolder(path);

    if (!FileHandler::exists(m_currentNote))
        setCurrentNote("");
}