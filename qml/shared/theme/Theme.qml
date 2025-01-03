import QtQuick

pragma Singleton

QtObject {
    property string name: "Default Theme"
    property bool isDarkTheme: true

    property ThemeColor color: ThemeColor {
        background: "#171717"
        surface: "#1e1e1e"
        text: "#ffffff"
        textHighlight: "#7efa8072"
        accent: "#fa8072"
        editorBackground: "#1e1e1e"
        editorText: "#ffffff"
        divider: "#2a2a2a"
        tooltip: "#383838"
        menuBackground: "#232323"
    }
}
