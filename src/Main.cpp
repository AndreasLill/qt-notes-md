#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "AppState.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    AppState *appState = new AppState();
    qmlRegisterSingletonInstance("AppState", 1, 0, "AppState", appState);
    appState = engine.singletonInstance<AppState*>("qtnotesmd", "AppState");

    QObject::connect(&app, &QCoreApplication::aboutToQuit, [&]() { appState->saveStateToFile(); });
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("qtnotesmd", "Main");

    return app.exec();
}
