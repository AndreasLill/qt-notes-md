#include "AppConfig.h"
#include "FileHandler.h"

#include <QStandardPaths>

namespace AppConfig
{
    QJsonObject loadStateFromFile()
    {
        QString configPath = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
        QString folderName = "qt-notes-md";
        QString fileName = "config.json";
        QString fullPath = QString("%1/%2/%3").arg(configPath, folderName, fileName);

        qDebug() << "Loaded state from" << fullPath;
        return FileHandler::readJson(fullPath);
    }

    void saveStateToFile(const QJsonObject &json)
    {
        QString configPath = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
        QString folderName = "qt-notes-md";
        QString fileName = "config.json";
        QString fullPath = QString("%1/%2/%3").arg(configPath, folderName, fileName);

        FileHandler::createFolder(configPath, folderName);
        FileHandler::saveJson(fullPath, json);
        qDebug() << "Saved state to" << fullPath;
    }
}