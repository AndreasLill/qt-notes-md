#include "filehandler.h"

#include <QFile>

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