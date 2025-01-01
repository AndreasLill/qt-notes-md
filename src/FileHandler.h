#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QString>

class FileHandler
{
public:
    static void saveFile(const QString &path, const QString &data);
    static QString readFile(const QString &path);
    static QString createFile(const QString &path, const QString &name);
    static QString createFolder(const QString &path, const QString &name);

    FileHandler() = delete;
};

#endif