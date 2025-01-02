import QtQuick

pragma Singleton

Item {
    function colorWithAlpha(color, alpha) {
        return Qt.hsla(color.hslHue, color.hslSaturation, color.hslLightness, alpha);
    }
}