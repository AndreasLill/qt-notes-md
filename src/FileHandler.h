#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QString>

namespace FileHandler
{
    void saveFile(const QString &path, const QString &data);
    QString readFile(const QString &path);
    QString createFile(const QString &path, const QString &name);
    QString createFolder(const QString &path, const QString &name);
}

#endif