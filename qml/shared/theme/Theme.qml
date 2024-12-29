import QtQuick

pragma Singleton

Item {
    readonly property ThemeBase themeDark: ThemeBase {
        background: "#232634"
        surface: "#303446"
        text: "#c6d0f5"
        accent: "#a6d189"
        transparent: "transparent"
    }

    property ThemeBase current: themeDark

    function colorWithAlpha(color, alpha) {
        return Qt.hsla(color.hslHue, color.hslSaturation, color.hslLightness, alpha);
    }
}