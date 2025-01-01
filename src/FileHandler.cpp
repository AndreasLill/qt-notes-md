#include "FileHandler.h"

#include <QFile>
#include <QDir>

void FileHandler::saveFile(const QString &path, const QString &data)
{
    if (path.isEmpty())
        return;
    if (data.isEmpty())
        return;

    QFile file(path);
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    file.write(data.toUtf8());
    file.close();
}

QString FileHandler::readFile(const QString &path)
{
    if (path.isEmpty())
        return {};

    QFile file(path);
    QTextStream stream(&file);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QString data = stream.readAll();
    file.close();
    return data;
}

QString FileHandler::createFile(const QString &path, const QString &name)
{
    if (path.isEmpty())
        return {};
    if (name.isEmpty())
        return {};
    
    const QString extension = {".md"};
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

QString FileHandler::createFolder(const QString &path, const QString &name)
{
    if (path.isEmpty())
        return {};
    if (name.isEmpty())
        return {};
    
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