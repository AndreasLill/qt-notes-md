#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "appstate.h"

int main(int argc, char *argv[])
{
    AppState *appState = new AppState();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterSingletonInstance("AppState", 1, 0, "AppState", appState);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("qtnotesmd", "Main");

    return app.exec();
}
