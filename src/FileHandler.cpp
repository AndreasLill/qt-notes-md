#include "FileHandler.h"

#include <QFile>
#include <QDir>

FileHandler::FileHandler(QObject *parent): QObject{parent}
{
    
}

QString FileHandler::readFile(const QString &path)
{
    if (path.isEmpty())
        return {};

    QFile file(path);
    QTextStream stream(&file);
    file.open(QIODevice::ReadOnly);
    return stream.readAll();
}

void FileHandler::createFile(const QString &path, const QString &name)
{
    if (path.isEmpty())
        return;
    if (name.isEmpty())
        return;
    
    const QString extension = {".md"};
    int count = 0;

    while (true)
    {
        QString fileName = (count > 0) ? QString("%1/%2 (%3)%4").arg(path, name, QString::number(count), extension) : QString("%1/%2%3").arg(path, name, extension);
        QFile file(fileName);
        if (!file.exists())
        {
            file.open(QIODevice::WriteOnly);
            break;
        }

        count++;
    }
}

void FileHandler::createFolder(const QString &path, const QString &name)
{
    if (path.isEmpty())
        return;
    if (name.isEmpty())
        return;
    
    int count = 0;

    while (true)
    {
        QString fullDirName = (count > 0) ? QString("%1/%2 (%3)").arg(path, name, QString::number(count)) : QString("%1/%2").arg(path, name);
        QDir fullDir(fullDirName);
        if (!fullDir.exists())
        {
            QString folderName = (count > 0) ? QString("%1 (%2)").arg(name, QString::number(count)) : name;
            QDir dir(path);
            dir.mkdir(folderName);
            break;
        }

        count++;
    }
}