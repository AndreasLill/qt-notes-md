#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>
#include <QQmlEngine>

class FileHandler : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    explicit FileHandler(QObject *parent = nullptr);
    Q_INVOKABLE static QString readFile(const QString &path);
    Q_INVOKABLE static QString createFile(const QString &path, const QString &name);
    Q_INVOKABLE static void createFolder(const QString &path, const QString &name);
};

#endif