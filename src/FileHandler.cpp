#include "FileHandler.h"

#include <QFile>
#include <QDir>
#include <QJsonDocument>

namespace FileHandler
{
    void saveJson(const QString &path, const QJsonObject &json)
    {
        if (path.isEmpty())
        {
            qDebug() << "Path is empty: " << path;
            return;
        }
        if (json.isEmpty())
        {
            qDebug() << "Json is empty: " << json;
            return;
        }

        QJsonDocument doc(json);
        QString jsonStr(doc.toJson(QJsonDocument::Indented).toStdString().c_str());
        FileHandler::saveFile(path, jsonStr);
    }

    void saveFile(const QString &path, const QString &data)
    {
        if (path.isEmpty())
        {
            qDebug() << "Path is empty: " << path;
            return;
        }
        if (data.isEmpty())
        {
            qDebug() << "Data is empty: " << data;
            return;
        }

        QFile file(path);
        file.open(QIODevice::WriteOnly | QIODevice::Text);
        file.write(data.toUtf8());
        file.close();
    }

    QJsonObject readJson(const QString &path)
    {
        QString jsonStr = FileHandler::readFile(path);
        QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonStr.toUtf8());
        return jsonDoc.object();
    }

    QString readFile(const QString &path)
    {
        if (path.isEmpty())
        {
            qDebug() << "Path is empty: " << path;
            return "";
        }

        QFile file(path);
        QTextStream stream(&file);
        file.open(QIODevice::ReadOnly | QIODevice::Text);
        QString data = stream.readAll();
        file.close();
        return data;
    }

    void createFile(const QString &path, const QString &name, const QString &extension)
    {
        if (path.isEmpty())
        {
            qDebug() << "Path is empty: " << path;
            return;
        }
        if (name.isEmpty())
        {
            qDebug() << "Name is empty: " << name;
            return;
        }
        if (extension.isEmpty())
        {
            qDebug() << "Extension is empty: " << extension;
            return;
        }

        QString fileName = QString("%1/%2%3").arg(path, name, extension);
        QFile file(fileName);
        file.open(QIODevice::WriteOnly | QIODevice::Text);
        file.close();
    }

    QString createFileIncremental(const QString &path, const QString &name, const QString &extension)
    {
        if (path.isEmpty())
        {
            qDebug() << "Path is empty: " << path;
            return "";
        }
        if (name.isEmpty())
        {
            qDebug() << "Name is empty: " << name;
            return "";
        }
        if (extension.isEmpty())
        {
            qDebug() << "Extension is empty: " << extension;
            return "";
        }
        
        int count = 0;
        while (true)
        {
            QString fileName = (count > 0) ? QString("%1/%2(%3)%4").arg(path, name, QString::number(count), extension) : QString("%1/%2%3").arg(path, name, extension);
            QFile file(fileName);
            if (!file.exists())
            {
                file.open(QIODevice::WriteOnly | QIODevice::Text);
                file.close();
                return fileName;
            }
            count++;
        }
    }

    void createFolder(const QString &path, const QString &name)
    {
        if (path.isEmpty())
        {
            qDebug() << "Path is empty: " << path;
            return;
        }
        if (name.isEmpty())
        {
            qDebug() << "Name is empty: " << name;
            return;
        }


        QDir dir(path);
        dir.mkdir(name);
    }

    QString createFolderIncremental(const QString &path, const QString &name)
    {
        if (path.isEmpty())
        {
            qDebug() << "Path is empty: " << path;
            return "";
        }
        if (name.isEmpty())
        {
            qDebug() << "Name is empty: " << name;
            return "";
        }
        
        int count = 0;
        while (true)
        {
            QString fullDirName = (count > 0) ? QString("%1/%2(%3)").arg(path, name, QString::number(count)) : QString("%1/%2").arg(path, name);
            QDir fullDir(fullDirName);
            if (!fullDir.exists())
            {
                QString folderName = (count > 0) ? QString("%1(%2)").arg(name, QString::number(count)) : name;
                QDir dir(path);
                dir.mkdir(folderName);
                return path + "/" + folderName;
            }
            count++;
        }
    }

    QString moveFile(const QString &fromPath, const QString &toPath, const QString &fileName)
    {
        if (fromPath == toPath)
            return "";
        if (fromPath.isEmpty())
        {
            qDebug() << "FromPath is empty: " << fromPath;
            return "";
        }
        if (toPath.isEmpty())
        {
            qDebug() << "ToPath is empty: " << toPath;
            return "";
        }
        if (fileName.isEmpty())
        {
            qDebug() << "FileName is empty: " << toPath;
            return "";
        }

        QFile file(fromPath);
        QFileInfo fileInfo(toPath);
        QString targetPath;

        if (fileInfo.isFile()) 
        {
            QString parentPath = fileInfo.absolutePath();
            targetPath = QString("%1/%2").arg(parentPath, fileName);
        }
        else
        {
            targetPath = QString("%1/%2").arg(toPath, fileName);
        }

        if (!file.rename(targetPath))
                return "";

        return targetPath;
    }

    void deleteFile(const QString &path)
    {
        QFile file(path);
        file.remove();
    }

    void deleteFolder(const QString &path)
    {
        QDir folder(path);
        folder.removeRecursively();
    }

    bool exists(const QString &path)
    {
        QFileInfo fileInfo(path);
        return fileInfo.exists();
    }
}