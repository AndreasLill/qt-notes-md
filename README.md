# QT Notes MD
A fast light-weight markdown note application written in C++ using QT for GUI.

# How to build with CMake and ninja
### Configure
cmake -DCMAKE_TOOLCHAIN_FILE:FILEPATH=\<QT_INSTALLATION_FOLDER\>/gcc_64/lib/cmake/Qt6/qt.toolchain.cmake --no-warn-unused-cli -S\<PROJECT_FOLDER\> -B\<PROJECT_FOLDER\>/build -G "Ninja Multi-Config"
### Build (Debug)
cmake --build \<PROJECT_FOLDER\>/build --config Debug
### Build (Release)
cmake --build \<PROJECT_FOLDER\>/build --config Release

#### Test ####