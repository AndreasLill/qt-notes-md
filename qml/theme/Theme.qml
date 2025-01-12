import QtQuick

pragma Singleton

QtObject {
    property string name: "Default Theme"
    property bool isDarkTheme: true

    property ThemeColor color: ThemeColor {
        background: "#1e2030"
        surface: "#24273a"
        overlay: "#181926"
        text: "#cad3f5"
        accent: "#a6da95"
        alert: "#ff3e37"
        editorBackground: "#363a4f"
        editorText: "#cad3f5"
        editorTextHighlight: "#60a6da95"
    }
}
