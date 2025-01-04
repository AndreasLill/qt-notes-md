#include "AppState.h"
#include "FileHandler.h"
#include <QStandardPaths>
#include <QJsonObject>

const QString AppState::APP_CONFIG_ROOT_PATH = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
const QString AppState::APP_CONFIG_FOLDER_NAME = "qt-notes-md";
const QString AppState::APP_CONFIG_FILE_NAME = "config.json";
const QString AppState::APP_CONFIG_FULL_PATH = QString("%1/%2/%3").arg(APP_CONFIG_ROOT_PATH, APP_CONFIG_FOLDER_NAME, APP_CONFIG_FILE_NAME);

void AppState::loadStateFromFile()
{
    QJsonObject json = FileHandler::readJson(APP_CONFIG_FULL_PATH);
    setWorkspace(json["workspace"].toString());
    setCurrentNote(json["currentNote"].toString());

    qDebug() << "Loaded state from" << APP_CONFIG_FULL_PATH;
}

void AppState::saveStateToFile()
{
    QJsonObject json;
    json["workspace"] = workspace;
    json["currentNote"] = currentNote;

    FileHandler::createFolder(APP_CONFIG_ROOT_PATH, APP_CONFIG_FOLDER_NAME);
    FileHandler::saveJson(APP_CONFIG_FULL_PATH, json);

    qDebug() << "Saved state to" << APP_CONFIG_FULL_PATH;
}

QString AppState::getWorkspace() const
{
    return workspace;
}

QString AppState::getCurrentNote() const
{
    return currentNote;
}

QString AppState::getEditorText() const
{
    return editorText;
}

int AppState::getEditorFontSize()
{
    return editorFontSize;
}

bool AppState::getEditorCanUndo()
{
    return editorCanUndo;
}

void AppState::setWorkspace(const QString &value)
{
    workspace = QString(value).replace("file://", "");
    emit workspaceChanged();
}

void AppState::setCurrentNote(const QString &value)
{
    if (currentNote == value)
        return;
    if (value == "")
        return;

    currentNote = value;
    QString data = FileHandler::readFile(value);
    setEditorText(data);
    emit currentNoteChanged();
}

void AppState::setEditorText(const QString &text)
{
    if (editorText == text)
        return;

    editorText = text;
    emit editorTextChanged();
}

void AppState::setEditorFontSize(int size)
{
    if (editorFontSize == size)
        return;

    editorFontSize = size;
    emit editorFontSizeChanged();
}

void AppState::setEditorCanUndo(bool value)
{
    if (editorCanUndo == value)
        return;

    editorCanUndo = value;
    emit editorCanUndoChanged();
}

void AppState::saveCurrentNote()
{
    FileHandler::saveFile(currentNote, editorText);
    emit currentNoteSaved();
}

QString AppState::createFile(const QString &path, const QString &name)
{
    return FileHandler::createFileIncremental(path, name, ".md");
}

QString AppState::createFolder(const QString &path, const QString &name)
{
    return FileHandler::createFolderIncremental(path, name);
}

