import Quickshell
import QtQuick
import Quickshell.Services.SystemTray
import QtQuick.Layouts

Row {
    spacing: 7
    Repeater {
        model: 9
        Text {
            property bool isActive: Hyprland.focusedWorkspace?.id ===(index+1)
            text: index+1
        font {
            weight: isActive ? 1000 : 300
        }
    }
    }
}