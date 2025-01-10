#pragma once

#include <QJsonObject>

namespace AppConfig
{
    QJsonObject loadStateFromFile();
    void saveStateToFile(const QJsonObject &json);
}