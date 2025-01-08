#pragma once

#include <QString>
#include <QJsonObject>

namespace FileHandler
{
    void saveJson(const QString &path, const QJsonObject &json);
    void saveFile(const QString &path, const QString &data);
    QJsonObject readJson(const QString &path);
    QString readFile(const QString &path);
    void createFile(const QString &path, const QString &name, const QString &extension);
    QString createFileIncremental(const QString &path, const QString &name, const QString &extension);
    void createFolder(const QString &path, const QString &name);
    QString createFolderIncremental(const QString &path, const QString &name);
    bool moveFile(const QString &fromPath, const QString &toPath, const QString &fileName);
}