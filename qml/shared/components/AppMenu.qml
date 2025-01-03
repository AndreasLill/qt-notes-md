import QtQuick
import QtQuick.Controls

Menu {
    id: root
    
    background: Rectangle {
        color: palette.base
        implicitWidth: 200
        implicitHeight: 32
        border.color: palette.mid
        border.width: 1
    }
    
    delegate: AppMenuItem {}
}