import Quickshell
import QtQuick
import QtQuick.Layouts
ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 32
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            Text {
                text: "workspaces here"
            }
            clock {}
        }
    }
}