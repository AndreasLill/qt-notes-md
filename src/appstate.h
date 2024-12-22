#ifndef APPSTATE_H
#define APPSTATE_H

#include <QObject>
#include <QQmlEngine>

class AppState : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit AppState(QObject *parent = nullptr);

signals:
};

#endif // APPSTATE_H
