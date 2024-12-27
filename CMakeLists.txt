cmake_minimum_required(VERSION 3.16)

project(qt-notes-md VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

include_directories(
    src
)

set_source_files_properties(qml/theme/Theme.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appqt-notes-md
    src/main.cpp
)

qt_add_qml_module(appqt-notes-md
    URI qtnotesmd
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/theme/Theme.qml
        qml/theme/ThemeBase.qml
        qml/workspace/Workspace.qml
        qml/workspace/WorkspacePicker.qml
        qml/editor/Editor.qml
    SOURCES
        src/appstate.h
        src/appstate.cpp
        src/workspaceviewmodel.h
        src/workspaceviewmodel.cpp
)

set_target_properties(appqt-notes-md PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqt-notes-md
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqt-notes-md
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appqt-notes-md
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
